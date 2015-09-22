//
//  MXMessage.h
//  MXNavigationController
//
//  Created by Max on 15/9/22.
//  Copyright (c) 2015年 Max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXMessage : NSObject

@property (nonatomic, strong)NSString *scheme;
@property (nonatomic, strong)NSString *host;
@property (nonatomic, strong)NSString *relative;
@property (nonatomic, strong)NSString *command;
@property (nonatomic, strong)NSMutableDictionary *args;


@end
