//
//  BaseAnimate.h
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseAnimate : NSObject{
    CADisplayLink *_displayLink;
    BOOL           _autoPlay;
    BOOL           _displayStart;
    BOOL           _displayOver;
    
    NSTimeInterval _startTime;
    NSTimeInterval _endTime;
    NSTimeInterval _duringTime;
    CGFloat        _process;
    CGFloat        _startProcess;
    CGFloat        _endProcess;
}


@property (nonatomic, assign)UIView *backgroundView;
@property (nonatomic, assign)UIView *foregroundView;
@property (nonatomic, assign)UIView *maskView;

- (void)play;
- (void)updateProcess:(CGFloat)process;

@end
