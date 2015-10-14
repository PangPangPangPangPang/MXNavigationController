//
//  MXNavigator.m
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "MXNavigator.h"
#import "UIViewController+mxNavi.h"

@implementation MXNavigator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageArray = [NSMutableArray new];
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

- (void)setCurrentPageController:(UIViewController *)currentPageController{
    _currentPageController = currentPageController;
    [_currentPageController setNavigator:self];
    [_pageArray addObject:currentPageController];
}

- (void)popPage{
    UIViewController *target = [_pageArray objectAtIndex:[_pageArray count] - 2];
    BaseAnimate *animate = [MXAnimateHelper animateWityType:[_currentPageController getAnimateType]
                                               andDirection:AnimeBackward];
    animate.backgroundView = target.view;
    animate.foregroundView = _currentPageController.view;
    [_currentPageController willMoveToParentViewController:nil];
    
    
}

- (void)gotoPage:(UIViewController *)pageController andAnimateType:(MXAnimateType)type{
    BaseAnimate *animate = [MXAnimateHelper animateWityType:type
                                               andDirection:AnimeForward];
    animate.backgroundView = _currentPageController.view;
    animate.foregroundView = pageController.view;
    {
        UIView *maskView = [UIView new];
        [maskView setFrame:_rootPageController.view.bounds];
        [_currentPageController.view addSubview:maskView];
        animate.maskView = maskView;
    }
    [pageController willMoveToParentViewController:self];
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
    [pageController didMoveToParentViewController:self];
    [animate prepare];
    [animate play];
    [self setCurrentPageController:pageController];
}

- (CGRect)screenFrame{
    return [UIScreen mainScreen].bounds;
}
@end
