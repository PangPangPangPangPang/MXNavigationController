//
//  UIViewController+mxNavi.h
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXNavigator.h"
#import "MXAnimateHelper.h"
#import "BaseAnimate.h"

@interface UIViewController (mxNavi)<MXNavigatorProtocol>

- (void)popPage;

@end
