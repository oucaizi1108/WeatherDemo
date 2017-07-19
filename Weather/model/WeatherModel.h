//
//  WeatherModel.h
//  WeatherDemo
//
//  Created by 杨锡钰 on 2017/7/19.
//  Copyright © 2017年 杨锡钰. All rights reserved.
//

/*
 
 ---  http://www.36wu.com/Service/Details/1?cid=1  开源接口文档数据 -----
 
 */

#import "BaseApiModel.h"

@interface WeatherModel : BaseApiModel

@property (nonatomic, copy) NSString *prov;         // 省
@property (nonatomic, copy) NSString *city;         // 检索的地区
@property (nonatomic, copy) NSString *district;     // 区域
@property (nonatomic, copy) NSString *dateTime;     // 日期
@property (nonatomic, copy) NSString *temp;         // 实时温度
@property (nonatomic, copy) NSString *minTemp;      // 最低温度
@property (nonatomic, copy) NSString *maxTemp;      // 最高温度
@property (nonatomic, copy) NSString *weather;      // 实时天气
@property (nonatomic, copy) NSString *windDirection;// 实时风向
@property (nonatomic, copy) NSString *windForce;    // 实时风力
@property (nonatomic, copy) NSString *humidity;     // 实时湿度
@property (nonatomic, copy) NSString *img_1;        // 白天所对应的天气图标
@property (nonatomic, copy) NSString *img_2;        // 夜间所对应的天气图标
@property (nonatomic, copy) NSString *refreshTime;  // 实时数据时间（气象观测站数据时间）

@end
