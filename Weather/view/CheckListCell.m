//
//  GGCancelTableviewCell.m
//  HotelGG
//
//  Created by hotelgg_yxy on 16/12/28.
//  Copyright © 2016年 Xinling. All rights reserved.
//

#import "CheckListCell.h"
#import "CommonHeader.h"
#import "CitySelectItem.h"

@interface CheckListCell ()

@property (nonatomic, strong) UILabel   *titleLa;
@property (nonatomic, assign) BOOL      isSelected;

@end

@implementation CheckListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        [self creatSubviews];
    }
    return self;
}

-(void)creatSubviews
{
    self.titleLa = [BaseFactory createLabelWithColor:[UIColor blackColor] fontSize:15 autoLayout:YES];
    self.titleLa.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLa];
    
    [self addSubviewsContraints];
}

- (void)addSubviewsContraints
{
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_titleLa]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLa)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLa attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void)reloadWithData:(id)data
{
    CitySelectItem *item = data;
    self.titleLa.text    = item.title;
    self.isSelected      = item.selected;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    if (!_isSelected){
        
        self.titleLa.textColor =  [UIColor blackColor];

    }else{
        
        self.titleLa.textColor = [UIColor redColor];
    }
}


@end
