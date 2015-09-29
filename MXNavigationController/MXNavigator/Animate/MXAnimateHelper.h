//
//  MXAnimateHelper.h
//  MXNavigationController
//
//  Created by Max on 15/9/23.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAnimate.h"

typedef NS_ENUM(NSInteger, MXAnimateType) {
    AnimateNone = 0,
    AnimateR2L = 1,
    AnimateL2R = 2
};

@interface MXAnimateHelper : NSObject

+ (BaseAnimate *)animateWityType:(MXAnimateType)type
                    andDirection:(MXAnimeDirection)direction;

@end
