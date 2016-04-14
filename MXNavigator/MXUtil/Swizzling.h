//
//  Swizzling.h
//  MXNavigationController
//
//  Created by Max Wang on 16/3/29.
//  Copyright © 2016年 Max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Swizzling : NSObject

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@end
