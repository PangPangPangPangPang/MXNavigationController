//
//  CommonViewController.m
//  MXNavigationController
//
//  Created by Max on 15/12/14.
//  Copyright © 2015年 Max. All rights reserved.
//

#import "CommonViewController.h"
#import "../MXNavigator/MXNavigator.h"

@implementation CommonViewController {
    UIButton *_actionButton;
    UIButton *_backButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor purpleColor]];
    _actionButton = [UIButton new];
    [_actionButton setBackgroundColor:[UIColor blackColor]];
    [_actionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_actionButton setTitle:@"reuse"
                   forState:UIControlStateNormal];
    [_actionButton addTarget:self
                      action:@selector(onTapBtn:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_actionButton];
    
    _backButton = [UIButton new];
    [_backButton setBackgroundColor:[UIColor blackColor]];
    [_backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backButton setTitle:@"next"
                   forState:UIControlStateNormal];
    [_backButton addTarget:self
                      action:@selector(onTapPop:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    NSDictionary *views = @{@"_actionButton" : _actionButton,
                            @"_backButton" : _backButton};
    NSDictionary *metrics = @{@"height" : @([UIScreen mainScreen].bounds.size.height / 2 - 50),
                              @"width" : @([UIScreen mainScreen].bounds.size.width / 2 - 50)};
    NSMutableArray *constraint = [NSMutableArray new];
    NSArray *constraintArrX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-width-[_actionButton(100)]-width-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views];
    [constraint addObjectsFromArray:constraintArrX];
    NSArray *constraintArrY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_actionButton(100)]-100-[_backButton(100)]"
                                                                      options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing
                                                                      metrics:metrics
                                                                        views:views];
    [constraint addObjectsFromArray:constraintArrY];

    [NSLayoutConstraint activateConstraints:constraint];
    NSLog(@"PviewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"PviewWillAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"PviewWillDisAapear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"PviewDidDisappear");
}


- (void)onTapPop:(id)sender {
    [[self getNavigator] gotoPageWithPageName:@"CommonViewController"
                                     pageNick:nil
                                         args:nil
                                    animeType:AnimateR2L];

}

+ (NSString *)barTitle {
    return @"reuse page";
}


- (void)onTapBtn:(id)sender {
    [[self getNavigator] gotoPageWithPageName:@"ViewController"
                                     pageNick:@"rootPage"
                                         args:nil
                                    animeType:AnimateR2L];

//    NSURL *url = [NSURL URLWithString:@"youlin://host/ViewController?nickName=rootPage"];
//    [[self getNavigator] poptoPageWithUrl:url];
}


@end
