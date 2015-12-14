//
//  NSString+Parser.m
//  MXNavigationController
//
//  Created by Max on 15/12/14.
//  Copyright © 2015年 Max. All rights reserved.
//

#import "NSString+Parser.h"

@implementation NSString (Parser)

- (NSDictionary *)parserQueryToDictory {
    NSMutableDictionary *result = [NSMutableDictionary new];
    NSArray *arr = [self componentsSeparatedByString:@"&"];
    for (NSString *temp in arr) {
        NSArray *tempArray = [temp componentsSeparatedByString:@"="];
        [result setValue:tempArray[1] forKey:tempArray[0]];
    }
    return result;
}

@end
