//
//  CityListView.m
//  WeatherDemo
//
//  Created by 杨锡钰 on 2017/7/19.
//  Copyright © 2017年 杨锡钰. All rights reserved.
//

#import "CityListView.h"
#import "CheckListCell.h"
#import "CommonHeader.h"

@interface CityListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, strong) CitySelectItem    *selectItem;

@end

@implementation CityListView

- (id)initWithlistData:(NSMutableArray *)listData
{
    if (self = [super init]){
        
        self.backgroundColor    = [UIColor clearColor];
        self.dataSource         = listData;
        [self createSubViews];
        [self.tableView reloadData];
    }
    
    return self;
}

- (void)createSubViews
{
    if (!_tableView){
        
        _tableView = [[UITableView alloc] init];
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.multipleTouchEnabled = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.userInteractionEnabled = YES;
    _tableView.layer.cornerRadius = 2.0;
    [self addSubview:_tableView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    [_tableView registerClass:[CheckListCell class] forCellReuseIdentifier:NSStringFromClass([CheckListCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CitySelectItem *item = self.dataSource[indexPath.row];
    NSString *indentifier = NSStringFromClass([CheckListCell class]);
    CheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    [cell reloadWithData:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (int i = 0; i < self.dataSource.count; i++){
        
        CitySelectItem *testItem = self.dataSource[i];
        
        if (i == indexPath.row){
            
            testItem.selected = YES;
            self.selectItem = testItem;
            
        }else{
            
            testItem.selected = NO;
        }
        
        [self.dataSource replaceObjectAtIndex:i withObject:testItem];
    }
    
    [self.tableView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clicked:withItem:)]){
        
        [self.delegate clicked:self withItem:self.selectItem];
    }
    
}

@end
