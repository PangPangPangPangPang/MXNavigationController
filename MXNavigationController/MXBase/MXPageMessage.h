//
//  MXPageMessage.h
//  MXNavigationController
//
//  Created by Max on 15/9/29.
//  Copyright © 2015年 Max. All rights reserved.
//

#import "MXMessage.h"

@interface MXPageMessage : MXMessage

@property (nonatomic, readonly, strong)NSString *pageNick;
@property (nonatomic, readonly, assign)NSInteger animateType;
@property (nonatomic, readonly, assign)NSInteger animateDirection;

- (id)initWithPageName:(NSString *)pageName
              pageNick:(NSString *)pageNick
               command:(NSString *)command
                  args:(NSDictionary *)args
              callBack:(NSURL *)callBack;

@end
