//
//  CLLViewTool.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CLLViewTool : UIResponder

+ (UILabel *)makeLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor block:(void(^ _Nullable)(UILabel *label))block;

+ (UIView *)makeVerticalLine:(void(^_Nullable)(UIView *line))block;

+ (UIView *)makeHorizontalLine:(void(^_Nullable)(UIView *line))block;

+ (UIButton *)makeButton:(void(^_Nullable)(UIButton *btn))block;

+ (UIButton *)makeButton:(void(^)(UIButton *btn))block layout:(void(^)(UIButton *btn))layout;

+ (UIImageView *)makeImageView:(UIImage *)image block:(void(^_Nullable)(UIImageView *imageView))block;

+ (UIImage *)makeImageFromView:(UIView *)view;

@end
NS_ASSUME_NONNULL_END
