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
    [_actionButton setTitle:@"back"
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
}

- (void)onTapPop:(id)sender {
    [[self getNavigator] gotoPageWithPageName:@"CommonViewController"
                                     pageNick:nil
                                         args:nil
                                    animeType:AnimateR2L];

}


- (void)onTapBtn:(id)sender {
    NSURL *url = [NSURL URLWithString:@"youlin://host/ViewController?nickName=rootPage"];
    [[self getNavigator] poptoPageWithUrl:url];
}


@end
