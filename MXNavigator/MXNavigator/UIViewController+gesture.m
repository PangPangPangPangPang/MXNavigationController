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

@implementation UIViewController (gesture)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod([self class], @selector(viewDidLoad), @selector(swizzling_viewDidLoad));
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
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
