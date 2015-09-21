//
//  MXNavigationController.h
//  MXNavigationController
//
//  Created by Max on 15/2/27.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseNavigationController;
@interface MXNavigationController : UIViewController

@property (nonatomic, retain) UINavigationBar *navigationBar;
@property (nonatomic, assign) BaseNavigationController *currentViewController;
@property (nonatomic, assign) BaseNavigationController *rootViewController;
@property (nonatomic, assign) BaseNavigationController *parenViewController;

- (void)pushToViewController:(UIViewController *)ViewController;
- (void)popViewController;
@end
