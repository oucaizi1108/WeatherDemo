//
//  BaseApiModel.m
//  WeatherDemo
//
//  Created by 杨锡钰 on 2017/7/18.
//  Copyright © 2017年 杨锡钰. All rights reserved.
//

#import "BaseApiModel.h"

@implementation BaseApiModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self toDictionary]];
}

@end
