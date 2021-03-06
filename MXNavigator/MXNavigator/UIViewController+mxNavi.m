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

- (void)setAnimateType:(MXAnimateType)type{
    objc_setAssociatedObject(self, @"MXAnimateType", [NSNumber numberWithInteger:type], OBJC_ASSOCIATION_ASSIGN);
}

- (MXAnimateType)getAnimateType{
    return [objc_getAssociatedObject(self, @"MXAnimateType") integerValue];
}

- (void)setNickName:(NSString *)nickName {
    objc_setAssociatedObject(self, @"nickName", nickName, OBJC_ASSOCIATION_COPY);

}
- (NSString *)nickName {
    return objc_getAssociatedObject(self, @"nickName");
}

- (void)setCommond:(NSString *)commond {
    objc_setAssociatedObject(self, @"commond", commond, OBJC_ASSOCIATION_COPY);
    
}
- (NSString *)commond {
    return objc_getAssociatedObject(self, @"commond");
}


- (void)setPageName:(NSString *)pageName {
    objc_setAssociatedObject(self, @"pageName", pageName, OBJC_ASSOCIATION_COPY);
    
}
- (NSString *)pageName {
    return objc_getAssociatedObject(self, @"pageName");
}

- (void)popPage {
    [[self getNavigator] popToPrePage];
}

@end
