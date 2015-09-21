//
//  SecondViewController.m
//  MXNavigationController
//
//  Created by Max on 15/2/27.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"嘻嘻";
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickBtn
{
    [self.naviController popViewController];
}


@end
