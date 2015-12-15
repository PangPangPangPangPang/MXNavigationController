//
//  MXPageMessage.m
//  MXNavigationController
//
//  Created by Max on 15/9/29.
//  Copyright © 2015年 Max. All rights reserved.
//

#import "MXPageMessage.h"

#define PAGE_HOST @"mx_page_host"

@implementation MXPageMessage

- (id)initWithPageName:(NSString *)pageName
              pageNick:(NSString *)pageNick
               command:(NSString *)command
                  args:(NSDictionary *)args
              callBack:(NSURL *)callBack {
    self = [super initWithHost:PAGE_HOST
                      relative:pageName
                       command:command
                          args:args];
    if (self) {
        if (pageNick) {
            _pageNick = pageNick;
        }
    }
    return self;
}

@end
