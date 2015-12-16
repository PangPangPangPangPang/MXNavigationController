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
    }
    return self;
}

- (void)play{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    _displayLink = [CADisplayLink displayLinkWithTarget:self
                                               selector:@selector(updateAnimate)];
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

- (void)prepare{
    if (_direction == AnimeBackward) {
        _process = 1.0;
    }
}

- (void)endAnime {
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

- (void)updateProcess:(CGFloat)process{
    _process = process;
}

@end
