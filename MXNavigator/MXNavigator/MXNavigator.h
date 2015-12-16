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

- (void)setPageName:(NSString *)pageName;
- (NSString *)pageName;

@end

@interface MXNavigator : UIViewController

@property (nonatomic, strong)UIViewController<MXNavigatorProtocol>  *rootPageController;
@property (nonatomic, weak)UIViewController<MXNavigatorProtocol>    *currentPageController;
@property (nonatomic, strong, readonly)NSMutableDictionary  *pageMap;

- (instancetype)initWithRootPageController:(UIViewController<MXNavigatorProtocol> *)root;

- (void)gotoPageWithPageName:(NSString *)pageName
                    pageNick:(NSString *)pageNick
                        args:(NSDictionary *)args
                   animeType:(MXAnimateType)type;
- (void)gotoPage:(UIViewController<MXNavigatorProtocol> *)pageController
  andAnimateType:(MXAnimateType)type;

- (void)poptoPageWithUrl:(NSURL *)url;
- (void)popToPage:(UIViewController<MXNavigatorProtocol> *)pageController;
- (void)popToPrePage;

@end
