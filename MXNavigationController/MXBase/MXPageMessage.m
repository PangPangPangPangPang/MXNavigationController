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
        _callBack = callBack;
        
        if (pageNick) {
            _pageNick = pageNick;
        }else {
            _pageNick = [NSString stringWithFormat:@"%@_%f",pageName,[NSDate date].timeIntervalSince1970];
        }
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super initWithUrl:url];
    if (self) {
        if ([_args valueForKey:@"nickName"]) {
            _pageNick = [_args valueForKey:@"nickName"];
        }else {
            _pageNick = [NSString stringWithFormat:@"%@_%f",_relative,[NSDate date].timeIntervalSince1970];
        }
        if ([_args valueForKey:@"callBack"]) {
            _callBack = [_args valueForKey:@"callBack"];
        }
    }
    return self;
}

@end
