//
//  MXNavigator.m
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "MXNavigator.h"
#import "UIViewController+mxNavi.h"
#import "UIViewController+generate.h"
#import "MXPageMessage.h"

@implementation MXNavigator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageMap = [NSMutableDictionary new];
    }
    return self;
}

- (instancetype)initWithRootPageController:(UIViewController<MXNavigatorProtocol> *)root {
    self = [self init];
    if (self) {
        self.rootPageController = root;
    }
    return self;
}

- (void)setRootPageController:(UIViewController *)rootPageController{
    if (rootPageController != _rootPageController) {
        _rootPageController = rootPageController;
        [_rootPageController willMoveToParentViewController:self];
        [_rootPageController.view setFrame:[self screenFrame]];
        [self addChildViewController:rootPageController];
        [self.view addSubview:_rootPageController.view];
        [_rootPageController didMoveToParentViewController:self];
        [self setCurrentPageController:_rootPageController];
    }
}

- (void)setCurrentPageController:(UIViewController<MXNavigatorProtocol> *)currentPageController {
    _currentPageController = currentPageController;
    [_currentPageController setNavigator:self];
    NSAssert([currentPageController nickName], @"need nickName");
    [_pageMap setValue:currentPageController forKey:[currentPageController nickName]];
}

- (void)popToPrePage {
    NSInteger index = [self.childViewControllers indexOfObject:_currentPageController];
    if (0 == index) {
        return;
    }
    UIViewController *target = self.childViewControllers[index - 1];
    [self popToPage:target];

}

- (void)poptoPageWithUrl:(NSURL *)url {
    MXPageMessage *message = [[MXPageMessage alloc] initWithUrl:url];
    UIViewController *vc = [_pageMap valueForKey:message.pageNick];
    if (!vc) {
        return;
    }
    [self popToPage:vc];
}

- (void)popToPage:(UIViewController<MXNavigatorProtocol> *)pageController {
    
    if (pageController == _currentPageController) {
        return;
    }
    [self removeMiddlePageController:pageController];
    

    BaseAnimate *animate = [MXAnimateHelper animateWityType:[_currentPageController getAnimateType]
                                               andDirection:AnimeBackward];
    animate.backgroundView = pageController.view;
    animate.foregroundView = _currentPageController.view;
    {
        UIView *maskView = [UIView new];
        [maskView setFrame:_rootPageController.view.bounds];
        [animate.backgroundView addSubview:maskView];
        animate.maskView = maskView;
    }

    [_currentPageController willMoveToParentViewController:nil];
    [pageController willMoveToParentViewController:self];
    [animate prepare];
    [animate play];
    [_currentPageController removeFromParentViewController];
    [_currentPageController didMoveToParentViewController:nil];
    [pageController didMoveToParentViewController:self];
    [self setCurrentPageController:pageController];
    
}

- (void)gotoPageWithPageName:(NSString *)pageName
                    pageNick:(NSString *)pageNick
                        args:(NSDictionary *)args
                   animeType:(MXAnimateType)type {
    MXPageMessage *message = [[MXPageMessage alloc] initWithPageName:pageName
                                                            pageNick:pageNick
                                                             command:@"init"
                                                                args:args
                                                            callBack:nil];
    UIViewController *vc = [UIViewController generateWithPageMessage:message];
    [self gotoPage:vc andAnimateType:type];
    
}

- (void)gotoPage:(UIViewController *)pageController andAnimateType:(MXAnimateType)type{
    BaseAnimate *animate = [MXAnimateHelper animateWityType:type
                                               andDirection:AnimeForward];
    [pageController setAnimateType:type];
    animate.backgroundView = _currentPageController.view;
    animate.foregroundView = pageController.view;
    {
        UIView *maskView = [UIView new];
        [maskView setFrame:_rootPageController.view.bounds];
        [animate.backgroundView addSubview:maskView];
        animate.maskView = maskView;
    }
    [pageController willMoveToParentViewController:self];

    [pageController.view setFrame:_currentPageController.view.frame];
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
    [animate prepare];
    [animate play];
    [pageController didMoveToParentViewController:self];
    [self setCurrentPageController:pageController];
}

#pragma mark -
#pragma mark Internal Method

- (void)removeMiddlePageController:(UIViewController *)target {
    NSInteger startIndex = [self.childViewControllers indexOfObject:target];
    NSInteger endIndex = [self.childViewControllers indexOfObject:_currentPageController];
    if (startIndex + 1 == endIndex) {
        return;
    }
    for (NSInteger i = endIndex - 1; i >= startIndex + 1; i--) {
        UIViewController<MXNavigatorProtocol> *vc = [self.childViewControllers objectAtIndex:i];
        [vc.view removeFromSuperview];
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
        [vc didMoveToParentViewController:nil];
        
        [_pageMap removeObjectForKey:vc.nickName];
    }
}

- (NSInteger)indexOfPageControllerViaNick:(NSString *)nick {
    UIViewController *vc = [_pageMap valueForKey:nick];
    if (!vc) {
        return NSIntegerMax;
    }
    NSInteger index = self.childViewControllers.count - 1;
    for (NSInteger i = self.childViewControllers.count - 1; i >= 0  ; i--) {
        if (self.childViewControllers[i] == vc) {
            index = i;
        }
    }
    return index;
}

- (CGRect)screenFrame{
    return [UIScreen mainScreen].bounds;
}
@end
