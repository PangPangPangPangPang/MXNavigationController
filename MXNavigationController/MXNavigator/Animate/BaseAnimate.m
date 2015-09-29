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
        _startProcess = 0.f;
        _endProcess = 1.f;
    }
    _process = (interval - _startTime) / _duringTime * (_endProcess - _startProcess) + _startProcess;
    if (_displayOver) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self updateProcess:_endProcess];
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop]
                                forMode:NSRunLoopCommonModes];
        [_displayLink invalidate];
    }else{
        [self updateProcess:_process];
        if (_process >= _endProcess) {
            _displayOver = YES;
        }
    }
}

- (void)prepare{
    
}

- (void)updateProcess:(CGFloat)process{
    _process = process;
}

@end
