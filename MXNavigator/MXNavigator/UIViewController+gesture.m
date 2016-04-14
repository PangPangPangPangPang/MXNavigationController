//
//  UIViewController+gesture.m
//  MXNavigationController
//
//  Created by Max on 15/12/16.
//  Copyright © 2015年 Max. All rights reserved.
//

#import "UIViewController+gesture.h"
#import "objc/runtime.h"
#import "MXNavigator.h"
#import "Swizzling.h"

@implementation UIViewController (gesture)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod([self class], @selector(viewDidLoad), @selector(swizzling_viewDidLoad));
    });
}

- (void)swizzling_viewDidLoad {
    [self swizzling_viewDidLoad];
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                  action:@selector(screenEdgePanGesture:)];
    [gesture setEdges:UIRectEdgeLeft];
    [self.view addGestureRecognizer:gesture];


}

- (void)screenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:EdgePanGesturePrepare
                                                                object:gesture];
        }
            break;
        case  UIGestureRecognizerStateChanged:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:EdgePanGestureChanged
                                                                object:gesture];

        }
            break;
        case  UIGestureRecognizerStateEnded:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:EdgePanGestureEnded
                                                                object:gesture];
        }

            break;
            
        default:
            break;
    }
}

@end
