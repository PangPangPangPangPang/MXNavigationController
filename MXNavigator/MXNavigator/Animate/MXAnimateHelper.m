//
//  MXAnimateHelper.m
//  MXNavigationController
//
//  Created by Max on 15/9/23.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "MXAnimateHelper.h"

@implementation MXAnimateHelper

+ (BaseAnimate *)animateWityType:(MXAnimateType)type andDirection:(MXAnimeDirection)direction{
    BaseAnimate *animate = nil;
    switch (type) {
        case AnimateNone:
            animate = [NSClassFromString(@"BaseAnimate") new];
            break;
        case AnimateR2L:
            animate = [NSClassFromString(@"R2LAnimate") new];
            break;
        case AnimateL2R:
            animate = [NSClassFromString(@"R2LAnimate") new];
            break;
        default:
            animate = [NSClassFromString(@"BaseAnimate") new];
            break;
    }
    animate.direction = direction;
    return animate;
}

@end
