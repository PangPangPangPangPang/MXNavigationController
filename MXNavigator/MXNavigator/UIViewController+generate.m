//
//  UIViewController+generate.m
//  MXNavigationController
//
//  Created by Max on 15/12/14.
//  Copyright © 2015年 Max. All rights reserved.
//

#import "UIViewController+generate.h"
#import "UIViewController+mxNavi.h"

@implementation UIViewController (generate)

+ (UIViewController<MXNavigatorProtocol> *)generateWithPageMessage:(MXPageMessage *)message {
    Class cls = NSClassFromString(message.relative);
    UIViewController *vc = [cls new];
    [vc setNickName:message.pageNick];
    [vc setPageName:message.relative];
    [vc setCommond:message.command];
    return vc;
}

@end
