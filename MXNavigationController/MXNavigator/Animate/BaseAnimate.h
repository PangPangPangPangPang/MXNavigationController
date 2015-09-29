//
//  BaseAnimate.h
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MXAnimeDirection) {
    AnimeForward  = 0,
    AnimeBackward = 1
};

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
    MXAnimeDirection _direction;
}


@property (nonatomic, weak)UIView *backgroundView;
@property (nonatomic, weak)UIView *foregroundView;
@property (nonatomic, weak)UIView *maskView;
@property (nonatomic, assign)MXAnimeDirection direction;

- (void)prepare;
- (void)play;
- (void)updateProcess:(CGFloat)process;

@end
