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

@implementation ViewController {
    UIButton *_actionButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _actionButton = [UIButton new];
    [_actionButton setBackgroundColor:[UIColor blackColor]];
    [_actionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_actionButton setTitle:@"next"
                   forState:UIControlStateNormal];
    [_actionButton addTarget:self
                      action:@selector(onTapBtn:)
  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_actionButton];
    
    NSDictionary *views = @{@"_actionButton" : _actionButton};
    NSDictionary *metrics = @{@"height" : @([UIScreen mainScreen].bounds.size.height / 2 - 50),
                              @"width" : @([UIScreen mainScreen].bounds.size.width / 2 - 50)};
    NSMutableArray *constraint = [NSMutableArray new];
    NSArray *constraintArrY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-height-[_actionButton]-height-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views];
    [constraint addObjectsFromArray:constraintArrY];
    NSArray *constraintArrX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-width-[_actionButton(100)]-width-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views];
    [constraint addObjectsFromArray:constraintArrX];
    [NSLayoutConstraint activateConstraints:constraint];

}

- (void)onTapBtn:(id)sender {
    [[self getNavigator] gotoPageWithPageName:@"CommonViewController"
                                     pageNick:nil
                                         args:nil
                                     animeType:AnimateR2L];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
