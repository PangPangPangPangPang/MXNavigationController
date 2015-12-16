//
//  MXMessage.m
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import "MXMessage.h"
#import "NSString+Parser.h"

#define MX_SCHEME @"MXScheme"
@implementation MXMessage

- (instancetype)initWithHost:(NSString *)host
                    relative:(NSString *)relative
                     command:(NSString *)command
                        args:(NSDictionary *)args {
    self = [super init];
    if (self) {
        _scheme = MX_SCHEME;
        _host = host;
        _relative = relative;
        _command = command;
        _args = [NSMutableDictionary dictionaryWithDictionary:args];
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        _scheme = url.scheme;
        _host = url.host;
        _relative = [url.relativePath substringFromIndex:1];
        _command = [url fragment];
        if ([url query])
            _args = [NSMutableDictionary dictionaryWithDictionary:[[url query] parserQueryToDictory]];
        else
            _args = nil;
        
        
    }
    return self;
}


@end
