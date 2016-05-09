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

@implementation MXNavigator {
    BaseAnimate *_panAnimate;
    UIViewController *_removedViewController;
}

#pragma mark -
#pragma mark LifeCycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageMap = [NSMutableDictionary new];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(edgePanGesturePrepareNoti:)
                                                     name:EdgePanGesturePrepare
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(edgePanGestureChangedNoti:)
                                                     name:EdgePanGestureChanged
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(edgePanGestureEndedNoti:)
                                                     name:EdgePanGestureEnded
                                                   object:nil];
        [self.view setFrame:[self screenFrame]];

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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Public Method


- (void)setRootPageController:(UIViewController *)rootPageController{
    if (rootPageController != _rootPageController) {
        _rootPageController = rootPageController;
        [_rootPageController willMoveToParentViewController:self];
        [_rootPageController.view setFrame:self.view.frame];
        [self addChildViewController:rootPageController];
        [self.view addSubview:_rootPageController.view];
        [_rootPageController didMoveToParentViewController:self];
        [self setCurrentPageController:_rootPageController];
    }
}

- (void)popToPrePage {
    UIViewController *target = [self prePageController:_currentPageController];
    if (!target) {
        return;
    }
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
    animate.delegate = self;
    _removedViewController = _currentPageController;
    animate.backgroundView = pageController.view;
    animate.foregroundView = _currentPageController.view;
    {
        UIView *maskView = [UIView new];
        [maskView setFrame:_rootPageController.view.bounds];
        [animate.backgroundView addSubview:maskView];
        animate.maskView = maskView;
    }
    [_currentPageController willMoveToParentViewController:nil];
    [self.view insertSubview:pageController.view
                belowSubview:_currentPageController.view];
    [pageController willMoveToParentViewController:self];
    
    [self.view insertSubview:pageController.view
                belowSubview:_currentPageController.view];
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
- (void)gotoPage:(UIViewController *)pageController
            args:(NSDictionary *)args
  andAnimateType:(MXAnimateType)type {
    if (pageController == _currentPageController) {
        return;
    }
    UIViewController<MXNavigatorProtocol>* reuseViewController = [self pushTargetPage:pageController];
    
    if (reuseViewController) {
        pageController = reuseViewController;
    }
    _removedViewController = _currentPageController;
    BaseAnimate *animate = [MXAnimateHelper animateWityType:type
                                               andDirection:AnimeForward];
    animate.delegate = self;
    [pageController setAnimateType:type];
    animate.backgroundView = _currentPageController.view;
    animate.foregroundView = pageController.view;
    {
        UIView *maskView = [UIView new];
        [maskView setFrame:animate.backgroundView.bounds];
        [animate.backgroundView addSubview:maskView];
        animate.maskView = maskView;
    }
    [pageController willMoveToParentViewController:self];
    
    if ([pageController respondsToSelector:@selector(processWithCommond:args:)]) {
        [pageController processWithCommond:pageController.commond args:args];
    }
    
    [pageController.view setFrame:self.view.frame];
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
    [animate prepare];
    [animate play];
    [pageController didMoveToParentViewController:self];
    [self setCurrentPageController:pageController];

}

- (void)gotoPage:(UIViewController *)pageController
  andAnimateType:(MXAnimateType)type{
    [self gotoPage:pageController
              args:nil
    andAnimateType:type];
}

#pragma mark -
#pragma mark Internal Method

- (void)setCurrentPageController:(UIViewController<MXNavigatorProtocol> *)currentPageController {
    _currentPageController = currentPageController;
    [_currentPageController setNavigator:self];
    NSAssert([currentPageController nickName], @"need nickName");
    [_pageMap setValue:currentPageController forKey:[currentPageController nickName]];
}

- (UIViewController<MXNavigatorProtocol> *)pushTargetPage:(UIViewController<MXNavigatorProtocol> *)target {
    UIViewController<MXNavigatorProtocol> *reusePageController = [_pageMap valueForKey:target.nickName];
    if (reusePageController) {
        reusePageController.view.transform = CGAffineTransformIdentity;
        [reusePageController removeFromParentViewController];
    }
    return reusePageController;
}

- (void)removeMiddlePageController:(UIViewController *)target {
    NSInteger startIndex = [self.childViewControllers indexOfObject:target];
    NSInteger endIndex = [self.childViewControllers indexOfObject:_currentPageController];
    if (startIndex + 1 == endIndex) {
        return;
    }
    for (NSInteger i = endIndex - 1; i >= startIndex + 1; i--) {
        UIViewController<MXNavigatorProtocol> *vc = [self.childViewControllers objectAtIndex:i];
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

- (UIViewController<MXNavigatorProtocol> *)prePageController:(UIViewController<MXNavigatorProtocol> *)pageController {
    NSInteger index = [self.childViewControllers indexOfObject:pageController];
    if (index == 0) {
        return nil;
    }
    UIViewController<MXNavigatorProtocol> * result = self.childViewControllers[index - 1];
    return result;
}

- (CGRect)screenFrame{
    return [UIScreen mainScreen].bounds;
}

#pragma mark -
#pragma mark Notification

- (void)edgePanGesturePrepareNoti:(NSNotification *)noti {
    UIViewController<MXNavigatorProtocol> *target = [self prePageController:_currentPageController];
    if (!target) {
        return;
    }
    if ([_currentPageController respondsToSelector:@selector(_MXNavigatorCanPopWithGesture)]
        && ![_currentPageController _MXNavigatorCanPopWithGesture]) {
        return;
    }
    _panAnimate = [MXAnimateHelper animateWityType:AnimateR2L
                                      andDirection:AnimeBackward];
    [_panAnimate setDelegate:self];
    [_panAnimate setIsPanGesture:YES];

    _removedViewController = _currentPageController;
    _panAnimate.foregroundView = _removedViewController.view;
    _panAnimate.backgroundView = target.view;
    {
        UIView *maskView = [UIView new];
        [maskView setFrame:_panAnimate.backgroundView.bounds];
        [_panAnimate.backgroundView addSubview:maskView];
        _panAnimate.maskView = maskView;
    }
    [_currentPageController willMoveToParentViewController:nil];
    [target willMoveToParentViewController:self];
    
    [self.view insertSubview:target.view
                belowSubview:_currentPageController.view];
    [_panAnimate prepare];
    [_panAnimate play];
}

- (void)edgePanGestureChangedNoti:(NSNotification *)noti {
    UIScreenEdgePanGestureRecognizer *gesture = noti.object;
    if (_panAnimate) {
        CGFloat process = 1 - [gesture translationInView:_currentPageController.view].x / _currentPageController.view.frame.size.width;
        [_panAnimate updateProcess:process];
    }
}

- (void)edgePanGestureEndedNoti:(NSNotification *)noti {
    [_panAnimate setIsPanEnded:YES];
    
}

#pragma mark -
#pragma mark Anime Delegate

- (void)baseAnimateDidFinishAnime:(BaseAnimate *)anime {
    if (anime.isPanGesture) {
        if (anime.panEndProcess > 0.5) {
            [_currentPageController didMoveToParentViewController:self];
            UIViewController<MXNavigatorProtocol> *target = [self prePageController:_currentPageController];
            [target.view removeFromSuperview];
            [target didMoveToParentViewController:nil];
        }else {
            UIViewController *target = [self prePageController:_removedViewController];
            [_removedViewController.view removeFromSuperview];
            [_removedViewController removeFromParentViewController];
            [_removedViewController didMoveToParentViewController:nil];
            [self setCurrentPageController:target];
            [_pageMap removeObjectForKey:_removedViewController.nickName];
        }
    }else {
        if (anime.direction == AnimeBackward) {
            [_pageMap removeObjectForKey:_removedViewController.nickName];
        }
        [_removedViewController.view removeFromSuperview];
    }
    _panAnimate = nil;
}

@end
