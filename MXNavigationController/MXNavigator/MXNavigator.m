//
//  MXNavigator.m
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "MXNavigator.h"
#import "UIViewController+mxNavi.h"
#import "UIViewController+generate.h"
#import "MXPageMessage.h"

@implementation MXNavigator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageMap = [NSMutableDictionary new];
    }
    return self;
}

- (instancetype)initWithRootPageController:(UIViewController<MXNavigatorProtocol> *)root {
    self = [self init];
    if (self) {
        self.rootPageController = root;
    }
    return self;
}

- (void)setRootPageController:(UIViewController *)rootPageController{
    if (rootPageController != _rootPageController) {
        _rootPageController = rootPageController;
        [_rootPageController willMoveToParentViewController:self];
        [_rootPageController.view setFrame:[self screenFrame]];
        [self addChildViewController:rootPageController];
        [self.view addSubview:_rootPageController.view];
        [_rootPageController didMoveToParentViewController:self];
        [self setCurrentPageController:_rootPageController];
    }
}

- (void)setCurrentPageController:(UIViewController<MXNavigatorProtocol> *)currentPageController {
    _currentPageController = currentPageController;
    [_currentPageController setNavigator:self];
    NSAssert([currentPageController nickName], @"need nickName");
    [_pageMap setValue:currentPageController forKey:[currentPageController nickName]];
}

- (void)popToPrePage {
    NSInteger index = [self.childViewControllers indexOfObject:_currentPageController];
    UIViewController *target = self.childViewControllers[index - 1];
    BaseAnimate *animate = [MXAnimateHelper animateWityType:[_currentPageController getAnimateType]
                                               andDirection:AnimeBackward];
    animate.backgroundView = target.view;
    animate.foregroundView = _currentPageController.view;
    {
        UIView *maskView = [UIView new];
        [maskView setFrame:_rootPageController.view.bounds];
        [animate.backgroundView addSubview:maskView];
        animate.maskView = maskView;
    }
    
    [target willMoveToParentViewController:self];
    [animate prepare];
    [animate play];
    [_currentPageController removeFromParentViewController];
    [target didMoveToParentViewController:self];
    [self setCurrentPageController:target];

}

- (void)popToPage:(UIViewController<MXNavigatorProtocol> *)pageController {
    NSInteger index = [self.childViewControllers indexOfObject:pageController];
    UIViewController *target = self.childViewControllers[index - 1];
    BaseAnimate *animate = [MXAnimateHelper animateWityType:[_currentPageController getAnimateType]
                                               andDirection:AnimeBackward];
    animate.backgroundView = target.view;
    animate.foregroundView = pageController.view;
    {
        UIView *maskView = [UIView new];
        [maskView setFrame:_rootPageController.view.bounds];
        [animate.backgroundView addSubview:maskView];
        animate.maskView = maskView;
    }

    [target willMoveToParentViewController:self];
    [animate prepare];
    [animate play];
    [_currentPageController removeFromParentViewController];
    [target didMoveToParentViewController:self];
    [self setCurrentPageController:target];
    
}

- (void)gotoPageWithPageName:(NSString *)pageName
                    pageNick:(NSString *)pageNick
                        args:(NSDictionary *)args
                   animeType:(MXAnimateType)type {
    MXPageMessage *message = [[MXPageMessage alloc] initWithPageName:pageName
                                                            pageNick:pageNick
                                                             command:@"init"
                                                                args:args
                                                            callBack:nil];
    UIViewController *vc = [UIViewController generateWithPageMessage:message];
    [self gotoPage:vc andAnimateType:type];
    
}

- (void)gotoPage:(UIViewController *)pageController andAnimateType:(MXAnimateType)type{
    BaseAnimate *animate = [MXAnimateHelper animateWityType:type
                                               andDirection:AnimeForward];
    [pageController setAnimateType:type];
    animate.backgroundView = _currentPageController.view;
    animate.foregroundView = pageController.view;
    {
        UIView *maskView = [UIView new];
        [maskView setFrame:_rootPageController.view.bounds];
        [animate.backgroundView addSubview:maskView];
        animate.maskView = maskView;
    }
    [pageController willMoveToParentViewController:self];

    [pageController.view setFrame:_currentPageController.view.frame];
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
    [animate prepare];
    [animate play];
    [pageController didMoveToParentViewController:self];
    [self setCurrentPageController:pageController];
}

- (CGRect)screenFrame{
    return [UIScreen mainScreen].bounds;
}
@end
