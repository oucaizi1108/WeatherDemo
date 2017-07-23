//
//  WeatherCell.m
//  WeatherDemo
//
//  Created by 杨锡钰 on 2017/7/19.
//  Copyright © 2017年 杨锡钰. All rights reserved.
//

#import "WeatherCell.h"
#import "CommonHeader.h"
#import "WeatherModel.h"

@interface WeatherCell ()

@property (nonatomic, strong) UILabel   *titleLa;
@property (nonatomic, strong) UILabel   *textLa;
@property (nonatomic, strong) UILabel   *subTitleLa;
@property (nonatomic, strong) UILabel   *subTextLa;
@property (nonatomic, strong) UIView    *bottomLine;

@end

@implementation WeatherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle              = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor             = [UIColor clearColor];
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews
{
    self.titleLa = [BaseFactory createLabelWithColor:[UIColor blackColor] fontSize:16 autoLayout:YES];
    [self.contentView addSubview:self.titleLa];
    
    self.textLa = [BaseFactory createLabelWithColor:[UIColor lightGrayColor] fontSize:13 autoLayout:YES];
    self.textLa.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.textLa];
    
    self.subTitleLa = [BaseFactory createLabelWithColor:[UIColor blackColor] fontSize:16 autoLayout:YES];
    [self.contentView addSubview:self.subTitleLa];
    
    self.subTextLa = [BaseFactory createLabelWithColor:[UIColor lightGrayColor] fontSize:13 autoLayout:YES];
    self.subTextLa.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.subTextLa];
    
    self.bottomLine                 = [BaseFactory createViewAutoLayout:YES];
    self.bottomLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.contentView addSubview:self.bottomLine];

    [self addSubviewsContraints];
}

- (void)addSubviewsContraints
{
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleLa]-(>=5)-[_textLa]-15-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_titleLa,_textLa)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_subTitleLa]-(>=5)-[_subTextLa]-15-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_subTitleLa,_subTextLa)]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLa]-10-[_subTitleLa]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLa,_subTitleLa)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_bottomLine]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bottomLine)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomLine(0.5)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bottomLine)]];
}

- (void)reloadWithData:(id)data
{
    WeatherModel *model = data;
    
    self.titleLa.text       = [NSString stringWithFormat:@"%@ %@  %@",model.prov,model.city,model.district];
    self.textLa.text        = model.dateTime;
    self.subTitleLa.text    =[NSString stringWithFormat:@"%@ %@",model.weather,model.temp];
    self.subTextLa.text     = model.windDirection;
    
}

@end
