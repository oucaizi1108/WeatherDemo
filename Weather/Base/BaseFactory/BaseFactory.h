//
//  BaseFactory.h
//  Weather
//
//  Created by 杨锡钰 on 2017/7/18.
//  Copyright © 2017年 杨锡钰. All rights reserved.
//

/*
 
 ----- 创建控件的工具类 ---------
 
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseFactory : NSObject

#pragma mark - make View
+ (UIView *)createViewAutoLayout:(BOOL)autoLayout;
+ (UIView *)createViewWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor autoLayout:(BOOL)autoLayout;
+ (UIView *)createViewWithBorderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor autoLayout:(BOOL)autoLayout;

#pragma mark - make Button
+ (UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFontSize:(CGFloat)fontSize
                             target:(id)target action:(SEL)aSelect autoLayout:(BOOL)autoLayout;
+ (UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFontSize:(CGFloat)fontSize
                        normalImage:(UIImage *)normalImage hightLigthImage:(UIImage *)hightLightImage
                             target:(id)target action:(SEL)aSelect autoLayout:(BOOL)autoLayout;
#pragma mark - make UIBarButtonItem
+ (UIBarButtonItem *)createBackBarButtonItemWithTarget:(id)target action:(SEL)aSelector;
+ (UIBarButtonItem *)createLeftButtonItemWithTarget:(id)target action:(SEL)aSelector title:(NSString *)title;
+ (UIBarButtonItem *)createLeftButtonItemWithTarget:(id)target action:(SEL)aSelector image:(UIImage *)image;
+ (UIBarButtonItem *)createRightButtonItemWithTarget:(id)target action:(SEL)aSelector title:(NSString *)title;
+ (UIBarButtonItem *)createRightButtonItemWithTarget:(id)target action:(SEL)aSelector image:(UIImage *)image;

#pragma mark - make Label
+ (UILabel *)createLabelWithColor:(UIColor *)textColor fontSize:(CGFloat)fontSize autoLayout:(BOOL)autoLayout;
+ (UILabel *)createLabelWithColor:(UIColor *)textColor fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment autoLayout:(BOOL)autoLayout;

#pragma mark - make textField
+ (UITextField *)createTextFieldWithTextColor:(UIColor *)textColor textFontSize:(CGFloat)fontSize placeHodler:(NSString *)placeHodler autoLayout:(BOOL)autoLayout;
+ (UITextField *)createTextFieldWithLeftPadding:(CGFloat)leftPadding rightPadding:(CGFloat)rightPadding
                                      textColor:(UIColor *)textColor textFontSize:(CGFloat)fontSize
                                    placeHodler:(NSString *)placeHodler returnKeyType:(UIReturnKeyType)returnKeyType autoLayout:(BOOL)autoLayout;
#pragma mark - make textView
+ (UITextView *)createTextViewWithTextColor:(UIColor *)textColor textFontSize:(CGFloat)fontSize autoLayout:(BOOL)autoLayout;
#pragma mark - make imageView
+ (UIImageView *)createImageViewWithImage:(UIImage *)image autoLayout:(BOOL)autoLayout;
+ (UIImageView *)createImageViewWithImage:(UIImage *)n_image hightLightedImage:(UIImage *)h_image autoLayout:(BOOL)autoLayout;


#pragma mark - attributionString
+ (NSAttributedString *)createAttributedWithText:(NSString *)text alignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing paragraphSpacing:(CGFloat)paragraphSpacing;

@end
