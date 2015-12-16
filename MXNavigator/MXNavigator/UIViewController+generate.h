//
//  UIViewController+generate.h
//  MXNavigationController
//
//  Created by Max on 15/12/14.
//  Copyright © 2015年 Max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXPageMessage.h"
#import "MXNavigator.h"

@interface UIViewController (generate)

+ (UIViewController<MXNavigatorProtocol> *)generateWithPageMessage:(MXPageMessage *)message;

@end
