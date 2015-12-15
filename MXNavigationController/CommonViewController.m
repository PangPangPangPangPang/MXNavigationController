//
//  CommonViewController.m
//  MXNavigationController
//
//  Created by Max on 15/12/14.
//  Copyright © 2015年 Max. All rights reserved.
//

#import "CommonViewController.h"
#import "UIViewController+mxNavi.h"

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor purpleColor]];
    UIButton *btn = [UIButton new];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn addTarget:self
            action:@selector(onTapBtn)
  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)onTapBtn{
    UIViewController *con = [CommonViewController new];
    [[self getNavigator] popPage];
//    [[self getNavigator] gotoPage:con
//                   andAnimateType:AnimateR2L];
}


@end
