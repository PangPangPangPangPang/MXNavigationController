//
//  MXPageController.m
//  MXNavigationController
//
//  Created by Max Wang on 16/4/14.
//  Copyright © 2016年 Max. All rights reserved.
//

#import "MXPageController.h"
#import "UIViewController+mxNavi.h"

#define navigation_bar_height 64

@implementation MXPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, navigation_bar_height)];
    [self.view addSubview:_navigationBar];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:[[self class] barTitle]];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    [item setLeftBarButtonItem:back];
    [_navigationBar setItems:@[item]];
}

+ (NSString *)barTitle {
    return @"";
}

- (void)back {
    [[self getNavigator] popToPrePage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:_navigationBar];
}

@end
