//
//  ViewController.m
//  MXNavigationController
//
//  Created by Max on 15/9/21.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+mxNavi.h"
#import "../MXNavigator/MXNavigator.h"
#import "CommonViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton new];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn addTarget:self
            action:@selector(onTapBtn)
  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@",[self class]);
}

- (void)onTapBtn{
    [[self getNavigator] gotoPageWithPageName:@"CommonViewController" pageNick:nil args:nil animeType:AnimateR2L];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
