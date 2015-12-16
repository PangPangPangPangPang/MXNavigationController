//
//  BaseAnimate.m
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "BaseAnimate.h"

@implementation BaseAnimate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _autoPlay = YES;
        _displayStart = YES;
        _duringTime = 0.4;
        _displayOver = NO;
        _isPanGesture = NO;
    }
    return self;
}

- (void)play{
    if (!_isPanGesture) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        _displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(updateAnimate)];
    }else {
        _displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(manualUpdateAnimate)];

    }
    [_displayLink setFrameInterval:1];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                       forMode:NSRunLoopCommonModes];
}

- (void)updateAnimate{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    if (_displayStart) {
        _displayStart = NO;
        _startTime = interval;
        _endTime = _startTime + _duringTime;
        _process = 0.f;
        if (_direction == AnimeForward) {
            _startProcess = 0.f;
            _endProcess = 1.f;
        }else{
            _startProcess = 1.f;
            _endProcess = 0.f;

        }
    }
    _process = (interval - _startTime) / _duringTime * (_endProcess - _startProcess) + _startProcess;
    
    if (_displayOver) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self updateProcess:_endProcess];
        [self endAnime];
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop]
                                forMode:NSRunLoopCommonModes];
        [_displayLink invalidate];
    }else{
        if (_process < 0) {
            _process = 0;
        }else if (_process > 1) {
            _process = 1;
        }

        [self updateProcess:_process];
        
        if ((interval - _startTime) / _duringTime >= 1) {
            _displayOver = YES;
        }
    }
}

- (void)manualUpdateAnimate {
    if (_isPanEnded) {
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        if (_displayStart) {
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            _displayStart = NO;
            _startTime = interval;
            if (_process > 0.5) {
                _duringTime = _duringTime * (1 - _process);
                _startProcess = _process;
                _endProcess = 1.f;
            }else{
                _duringTime = _duringTime * _process;
                _startProcess = _process;
                _endProcess = 0.f;
            }
            _endTime = _startTime + _duringTime;

        }
        _process = (interval - _startTime) / _duringTime * (_endProcess - _startProcess) + _startProcess;
        
        if (_displayOver) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [self updateProcess:_endProcess];
            [self endAnime];
            [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop]
                                    forMode:NSRunLoopCommonModes];
            [_displayLink invalidate];
        }else{
            if (_process < 0) {
                _process = 0;
            }else if (_process > 1) {
                _process = 1;
            }
            
            [self updateProcess:_process];
            
            if ((interval - _startTime) / _duringTime >= 1) {
                _displayOver = YES;
            }
        }
        
    }else {
        [self updateProcess:_process];
    }
}

- (void)prepare{
    if (_direction == AnimeBackward) {
        _process = 1.0;
    }
}

- (void)endAnime {
    if (_delegate && [_delegate respondsToSelector:@selector(baseAnimateDidFinishAnime:)]) {
        [_delegate baseAnimateDidFinishAnime:self];
    }
    [self.maskView removeFromSuperview];
}

- (void)setDirection:(MXAnimeDirection)direction {
    _direction = direction;
    switch (_direction) {
        case AnimeForward:
            _startProcess = 0;
            break;
        case AnimeBackward:
            _startProcess = 1;
            break;
        default:
            break;
    }
}

- (void)setIsPanEnded:(BOOL)isPanEnded {
    _panEndProcess = _process;
    _isPanEnded = isPanEnded;
}

- (void)setIsPanGesture:(BOOL)isPanGesture {
    _process = 1;
    _isPanGesture = isPanGesture;
}

- (void)updateProcess:(CGFloat)process{
    _process = process;
}

@end
