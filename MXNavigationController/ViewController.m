//
//  ViewController.m
//  MXNavigationController
//
//  Created by Max on 15/9/21.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+mxNavi.h"
#import "MXMessage.h"
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
    MXMessage *message = [[MXMessage alloc] initWithUrl:[NSURL URLWithString:@"http://mmmmmax.wang/archives?ad=c&cd=2&dd=7"]];

}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@",[self class]);
}

- (void)onTapBtn{
    UIViewController *con = [CommonViewController new];
    [[self getNavigator] gotoPage:con
                   andAnimateType:AnimateR2L];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
