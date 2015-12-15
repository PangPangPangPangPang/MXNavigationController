//
//  MXMessage.h
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXMessage : NSObject {
    NSMutableDictionary *_args;
    NSString            *_scheme;
    NSString            *_relative;
    NSString            *_command;
    NSString            *_host;
}

@property (nonatomic, copy)NSString *scheme;
@property (nonatomic, copy)NSString *host;
@property (nonatomic, copy)NSString *relative;
@property (nonatomic, copy)NSString *command;
@property (nonatomic, strong)NSMutableDictionary *args;

- (instancetype)initWithHost:(NSString *)host
                    relative:(NSString *)relative
                     command:(NSString *)command
                        args:(NSDictionary *)args;
- (instancetype)initWithUrl:(NSURL *)url;

@end
