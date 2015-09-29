//
//  UIViewController+mxNavi.m
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "UIViewController+mxNavi.h"
#import <objc/runtime.h>

@implementation UIViewController (mxNavi)

- (void)setNavigator:(MXNavigator *)navigator{
    objc_setAssociatedObject(self, @"navigator", navigator, OBJC_ASSOCIATION_ASSIGN);
}

- (MXNavigator *)getNavigator{
    return objc_getAssociatedObject(self, @"navigator");
}

@end