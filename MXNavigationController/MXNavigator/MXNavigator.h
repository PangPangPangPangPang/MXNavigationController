//
//  MXNavigator.h
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAnimate.h"
#import "Animate/MXAnimateHelper.h"

@class MXNavigator;
@protocol MXNavigatorProtocol <NSObject>

- (void)setNavigator:(MXNavigator *)navigator;
- (MXNavigator *)getNavigator;

- (void)setAnimateType:(MXAnimateType)type;
- (MXAnimateType)getAnimateType;

- (void)setNickName:(NSString *)nickName;
- (NSString *)nickName;

@end

@interface MXNavigator : UIViewController

@property (nonatomic, strong)UIViewController  *rootPageController;
@property (nonatomic, weak)UIViewController    *currentPageController;
@property (nonatomic, strong, readonly)NSMutableArray    *pageArray;

- (void)gotoPage:(UIViewController *)pageController
  andAnimateType:(MXAnimateType)type;
- (void)popPage;

@end
