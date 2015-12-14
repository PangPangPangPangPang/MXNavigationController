//
//  MXMessage.h
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXMessage : NSObject

@property (nonatomic, copy)NSString *scheme;
@property (nonatomic, copy)NSString *host;
@property (nonatomic, copy)NSString *relative;
@property (nonatomic, copy)NSString *command;
@property (nonatomic, strong)NSMutableDictionary *args;

- (instancetype)initWithScheme:(NSString *)scheme
                          Host:(NSString *)host
                      Relative:(NSString *)relative
                       Commond:(NSString *)command
                          Args:(NSDictionary *)args;
- (instancetype)initWithUrl:(NSURL *)url;

@end
