//
//  R2LAnimate.m
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "R2LAnimate.h"

@implementation R2LAnimate

- (void)prepare{
    [super prepare];
    if (_direction == AnimeForward) {
        [self.foregroundView setTransform:CGAffineTransformMakeTranslation(self.backgroundView.frame.size.width, 0)];
        [self.maskView setBackgroundColor:[UIColor blackColor]];
        [self.maskView setAlpha:0];
    }else {
        [self.maskView setBackgroundColor:[UIColor blackColor]];
        [self.maskView setAlpha:0.65];
    }
}

- (void)updateProcess:(CGFloat)process{
    [super updateProcess:process];
    [self.backgroundView setTransform:CGAffineTransformMakeTranslation(-self.backgroundView.frame.size.width * 0.4 * _process, 0)];
    [self.maskView setAlpha:0.65 * _process];
    [self.foregroundView setTransform:CGAffineTransformMakeTranslation(self.backgroundView.frame.size.width * (1 - _process), 0)];
}

@end
