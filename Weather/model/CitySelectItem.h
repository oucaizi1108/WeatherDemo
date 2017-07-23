//
//  CitySelectItem.h
//  WeatherDemo
//
//  Created by 杨锡钰 on 2017/7/19.
//  Copyright © 2017年 杨锡钰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitySelectItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL      selected;

@end
