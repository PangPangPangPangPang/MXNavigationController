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
    [self cycleFromViewController:_currentPageController toViewController:pageController];
}

- (void)popPage{
    
}

- (void)cycleFromViewController:(UIViewController*)oldVC
               toViewController:(UIViewController*)newVC{
    [oldVC willMoveToParentViewController:nil];
    [newVC willMoveToParentViewController:self];
    [self addChildViewController:newVC];
    
    [newVC.view setFrame:CGRectMake([self screenFrame].size.width,
                                    [self screenFrame].origin.y,
                                    [self screenFrame].size.width,
                                    [self screenFrame].size.height)];
    
    [self transitionFromViewController:oldVC
                      toViewController:newVC
                              duration:0.4
                               options:UIViewAnimationOptionLayoutSubviews
                            animations:^{
                                [newVC.view setFrame:[self screenFrame]];
                                [oldVC.view setFrame:CGRectMake(-[self screenFrame].size.width,
                                                                [self screenFrame].origin.y,
                                                                [self screenFrame].size.width,
                                                                [self screenFrame].size.height)];
        
    }
                            completion:^(BOOL finished) {
                                [self setCurrentPageController:newVC];
                                [newVC didMoveToParentViewController:self];
                                [oldVC removeFromParentViewController];
        
    }];
}

- (CGRect)screenFrame{
    return [UIScreen mainScreen].bounds;
}
@end
