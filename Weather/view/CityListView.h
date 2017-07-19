//
//  CityListView.h
//  WeatherDemo
//
//  Created by 杨锡钰 on 2017/7/19.
//  Copyright © 2017年 杨锡钰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitySelectItem.h"

@protocol CityListViewDelegate;

@interface CityListView : UIView

- (id)initWithlistData:(NSMutableArray *)listData;

@property (nonatomic, weak) id <CityListViewDelegate>delegate;

@end

@protocol CityListViewDelegate <NSObject>

- (void)clicked:(CityListView *)view withItem:(CitySelectItem *)item;
@end
