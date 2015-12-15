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
    
    UIButton *btn1 = [UIButton new];
    [btn1 setFrame:CGRectMake(100, 300, 100, 100)];
    [btn1 setBackgroundColor:[UIColor blackColor]];
    [btn1 addTarget:self
            action:@selector(onTapBtn1)
  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];


}

- (void)onTapBtn1{
    [[self getNavigator] gotoPageWithPageName:@"CommonViewController" pageNick:nil args:nil animeType:AnimateR2L];

}


- (void)onTapBtn{
    [self popPage];
}


@end
