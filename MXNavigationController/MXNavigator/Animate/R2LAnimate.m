//
//  R2LAnimate.m
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "R2LAnimate.h"

@implementation R2LAnimate

- (void)updateProcess:(CGFloat)process{
    [super updateProcess:process];
    [self.backgroundView setTransform:CGAffineTransformMakeTranslation(-self.backgroundView.frame.size.width * 0.4 * _process, 0)];
    [self.foregroundView setTransform:CGAffineTransformMakeTranslation(self.foregroundView.frame.size.width * (1 - _process), 0)];
}

@end
