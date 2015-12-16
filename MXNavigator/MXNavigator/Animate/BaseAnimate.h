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
@class BaseAnimate;
@protocol BaseAnimateDelegate <NSObject>

- (void)baseAnimateDidFinishAnime:(BaseAnimate *)anime;

@end

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
    id<BaseAnimateDelegate> delegate;
}

@property (nonatomic, weak)UIView *backgroundView;
@property (nonatomic, weak)UIView *foregroundView;
@property (nonatomic, weak)UIView *maskView;
@property (nonatomic, assign)MXAnimeDirection direction;
@property (nonatomic, assign)BOOL isPanGesture;
@property (nonatomic, assign)BOOL isPanEnded;
@property (nonatomic, assign)CGFloat panEndProcess;
@property (nonatomic, weak)id<BaseAnimateDelegate> delegate;

- (void)prepare;
- (void)play;
- (void)updateProcess:(CGFloat)process;

@end
