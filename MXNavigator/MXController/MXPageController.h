//
//  MXPageController.h
//  MXNavigationController
//
//  Created by Max Wang on 16/4/14.
//  Copyright © 2016年 Max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXNavigator.h"
#import "PageConfig.h"

@interface MXPageController : UIViewController {
    UINavigationBar *_navigationBar;
}

@property (nonatomic, retain)UINavigationBar *navigationBar;

+ (NSString *)barTitle;
- (void)processInitCommondWithArgs:(NSDictionary *)args;

@end
