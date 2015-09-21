//
//  MXNavigationController.m
//  MXNavigationController
//
//  Created by Max on 15/2/27.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "MXNavigationController.h"
#import "BaseNavigationController.h"

@implementation MXNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)pushToViewController:(BaseNavigationController *)ViewController
{
    [self addChildViewController:ViewController];
    [ViewController willMoveToParentViewController:_currentViewController];
    [self.view addSubview:ViewController.view];

    __weak id weakSelf = self;
    ViewController.naviController = weakSelf;

    [self transitionFromViewController:_currentViewController toViewController:ViewController duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
    } completion:^(BOOL finished) {
        _parenViewController = _currentViewController;
        _currentViewController = ViewController;
        _currentViewController.naviController = self;
        
        [ViewController didMoveToParentViewController:weakSelf];
    }];
}

- (void)popViewController
{
    [_currentViewController willMoveToParentViewController:nil];
    [_currentViewController.view removeFromSuperview];
    [_currentViewController removeFromParentViewController];

//    [self transitionFromViewController:_currentViewController toViewController:_parenViewController duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        
//    } completion:^(BOOL finished) {
//        //        [_currentViewController.view removeFromSuperview];
//        //        [_currentViewController removeFromParentViewController];
//        _currentViewController = _parenViewController;
//    }];

}

- (void)setRootViewController:(BaseNavigationController *)rootViewController
{
    _rootViewController = rootViewController;
    _currentViewController = _rootViewController;
    __weak id weakSelf = self;
    _parenViewController = weakSelf;
    _rootViewController.naviController = weakSelf;

    
    [self addChildViewController:_rootViewController];
    [_rootViewController willMoveToParentViewController:self];
    [self.view addSubview:_rootViewController.view];
    
    [_rootViewController didMoveToParentViewController:self];
}

@end
