//
//  ViewController.m
//  MXNavigationController
//
//  Created by Max on 15/2/27.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"嘻嘻";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickBtn
{
    NSLog(@"!!!%@",[self.naviController class]);
    SecondViewController *second = [[SecondViewController alloc] init];
    [self.naviController pushToViewController:second];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"1111");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"2222");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
