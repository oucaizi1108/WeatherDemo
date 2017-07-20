//
//  ViewController.m
//  Weather
//
//  Created by 杨锡钰 on 2017/7/19.
//  Copyright © 2017年 杨锡钰. All rights reserved.
//

#import "ViewController.h"
#import "CommonHeader.h"
#import "WeatherCell.h"
#import "CitySelectItem.h"

#import "CityListView.h"
#import "WeatherModel.h"

#define HTTP_REQUSET_GET    @"GET"
#define HTTP_REQUSET_POST   @"POST"
#define HTTP_REQUSET_PUT    @"PUT"
#define HTTP_REQUSET_DELET  @"DELETE"
#define AUTHKEY             @"1e90bcf9b5eb49d49c2932e455074ff9"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,CityListViewDelegate>

@property (nonatomic,   copy) NSString              *apiHost;
@property (nonatomic, strong) AFHTTPSessionManager  *AFManager;
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableDictionary   *cellHeightsDictionary;
@property (nonatomic, strong) UIView                *headView;
@property (nonatomic, strong) UITextField           *textField;
@property (nonatomic, strong) NSMutableArray        *dataSource;

// 选择城市的相关控件
@property (nonatomic, strong) UIView                *platView;
@property (nonatomic, strong) CityListView          *cityListView;
@property (nonatomic, strong) NSMutableArray        *cityList;
@property (nonatomic, strong) CitySelectItem        *selectItem;
@property (nonatomic, assign) BOOL                  extendBool;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.apiHost   = @"http://api.36wu.com/Weather/GetWeather";
    self.AFManager = [AFHTTPSessionManager manager];
    self.AFManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.dataSource = [NSMutableArray array];
    _cellHeightsDictionary = @{}.mutableCopy;
    
    [self getCityListDataFromLocalJson];
    
    NSString *districtId = @"";
    if (self.cityList && self.cityList.count > 0) {
        
        self.selectItem = [self.cityList firstObject];
        districtId = self.selectItem.value;
        
    }else{
        
        districtId = @"101010100";
    }
    
    [self createSubviews];
    [self refreshFieldText];
    [self weatherRequest:districtId];
}

#pragma mark - 城市列表加载本地json文件
- (void)getCityListDataFromLocalJson
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CityListEntity" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    self.cityList = [NSMutableArray array];
    for (int i = 0; i < array.count; i++){
        
        CitySelectItem *item = [[CitySelectItem alloc] init];
        NSDictionary *dict  = array[i];
        item.title          = dict[@"title"];
        item.value          = dict[@"value"];
        item.selected       = [dict[@"selected"] boolValue];
        
        [self.cityList addObject:item];
    }
    
}

- (void)createSubviews
{
    self.title = @"天气查询";
    [self createHeadView];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), SCREEN_W, SCREEN_H - CGRectGetMaxY(self.headView.frame)) ;
    [self.tableView registerClass:[WeatherCell class] forCellReuseIdentifier:NSStringFromClass([WeatherCell class])];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.platView];
    [self.platView addSubview:self.cityListView];
    [self updateNaviListViewLayout];
    self.platView.hidden = YES;
}

- (void)createHeadView
{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, 60)];
    self.headView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.headView];
    
    self.textField = [BaseFactory createTextFieldWithTextColor:[UIColor blackColor] textFontSize:14 placeHodler:@"请输入城市ID" autoLayout:YES];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = leftView;
    self.textField.layer.cornerRadius = 2.0;
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:self.textField];
    
    [self.headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_textField]-15-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_textField)]];
    [self.headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_textField(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textField)]];
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView                      = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _tableView.separatorStyle       = UITableViewCellSeparatorStyleNone;
        _tableView.delegate             = self;
        _tableView.dataSource           = self;
        _tableView.multipleTouchEnabled = NO;
        _tableView.backgroundColor      = [UIColor clearColor];
    }
    
    return _tableView;
}

- (UIView *)platView
{
    if (!_platView){
        
        _platView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _platView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(platViewClicked:)];
        singleRecognizer.delegate = self;
        [_platView addGestureRecognizer:singleRecognizer];
    }
    return _platView;
}

- (CityListView *)cityListView
{
    if (!_cityListView){
        
        _cityListView = [[CityListView alloc] initWithlistData:self.cityList];
        _cityListView.translatesAutoresizingMaskIntoConstraints = NO;
        _cityListView.backgroundColor = [UIColor clearColor];
        _cityListView.delegate = self;
    }
    
    return _cityListView;
}

- (void)updateNaviListViewLayout
{
    [self.platView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_cityListView]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cityListView)]];
    [self.platView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-115-[_cityListView(240)]" options:0 metrics:@{@"H":@((self.cityList.count) * 40)} views:NSDictionaryOfVariableBindings(_cityListView)]];
    [self.platView addConstraint:[NSLayoutConstraint constraintWithItem:_cityListView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.platView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
}

- (void)refreshFieldText
{
    self.textField.text = self.selectItem.title;
}

- (void)platViewClicked:(UITapGestureRecognizer *)recognizer
{
    self.extendBool = !self.extendBool;
}

#pragma mark - 选中列表之后的delegate回调 刷新网络请求和页面
- (void)clicked:(CityListView *)view withItem:(CitySelectItem *)item
{
    self.extendBool = NO;
    self.selectItem = item;
    [self refreshFieldText];
    [self weatherRequest:item.value];
}

#pragma mark - extendBool属性值来控制城市列表的显示与隐藏
- (void)setExtendBool:(BOOL)extendBool
{
    _extendBool = extendBool;
    
    if (_extendBool) {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.cityListView.hidden = NO;
            self.platView.hidden = self.cityListView.hidden;
            
        }];
        
    }else {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.cityListView.hidden = YES;
            self.platView.hidden = self.cityListView.hidden;
            
        }];
    }
}

#pragma mark - 点击textField弹出选择城市列表
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.extendBool = !self.extendBool;
    return NO;
}

#pragma mark - 进行手势拦截，如果点击区域在子视图内 就拦截
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.cityListView]){
        
        return NO;
    }
    return YES;
}

#pragma mark - 接口请求
-(void)weatherRequest:(NSString *)districtId
{
    NSDictionary *dict = @{
                           @"district":districtId,
                           @"authkey":AUTHKEY,
                           @"type":@"JSON"
                           };
    
    __weak ViewController *weakSelf = self;
    
    [self.AFManager GET:self.apiHost parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        __strong ViewController *strongSelf = weakSelf;
        
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject ? : [NSData data]
                                                             options:NSJSONReadingMutableContainers
                                                               error:nil];
        }
        
        NSData *  data       = [NSJSONSerialization dataWithJSONObject:responseObject ?: @{} options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%ld-----%@\nbody:\n%@\n", urlResponse.statusCode, strongSelf.apiHost, jsonString);
        
        WeatherModel *model = [[WeatherModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
        
        [strongSelf.dataSource addObject:model];
        
        [strongSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%@",error);
    }];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSNumber *height = [self.cellHeightsDictionary objectForKey:indexPath];
    if (height)
        return height.doubleValue;
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cellHeightsDictionary setObject:@(cell.frame.size.height) forKey:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    WeatherModel *model = self.dataSource[indexPath.row];
    NSString *indentifier = NSStringFromClass([WeatherCell class]);
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    [cell reloadWithData:model];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
