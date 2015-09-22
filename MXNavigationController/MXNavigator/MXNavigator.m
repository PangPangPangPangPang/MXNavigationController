//
//  MXNavigator.m
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "MXNavigator.h"
#import "UIViewController+mxNavi.h"
#import "R2LAnimate.h"

@implementation MXNavigator

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
}

- (void)gotoPage:(UIViewController *)pageController{
    R2LAnimate *animate = [R2LAnimate new];
    animate.backgroundView = _currentPageController.view;
    animate.foregroundView = pageController.view;
    [pageController willMoveToParentViewController:self];
    [pageController.view setFrame:[self screenFrame]];
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
    [pageController didMoveToParentViewController:self];
    [animate play];
    [self setCurrentPageController:pageController];
}

- (void)popPage{
    
}

- (CGRect)screenFrame{
    return [UIScreen mainScreen].bounds;
}
@end
