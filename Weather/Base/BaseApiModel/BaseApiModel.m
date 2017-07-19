//
//  BaseApiModel.m
//  WeatherDemo
//
//  Created by 杨锡钰 on 2017/7/18.
//  Copyright © 2017年 杨锡钰. All rights reserved.
//

#import "BaseApiModel.h"

@implementation BaseApiModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (instancetype)mockInstance;
{
    NSAssert(NO, @"需要子类继承并实现");
    
    return nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self toDictionary]];
}

@end
