//
//  UILabel+CLLFrame.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>

/**获取矩形的中心点*/
CGPoint CGRectGetCenter(CGRect rect);
/**获取移动后矩形的位置大小*/
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (CLLFrame)
@property CGSize size;
@property CGFloat height;
@property CGFloat width;
@property CGPoint origin;
@property CGFloat top;
@property CGFloat left;
@property CGFloat bottom;
@property CGFloat right;
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
/**
 根据增量移动位置

 @param var 移动位置的增量
 */
- (void)cll_moveBy:(CGPoint)var;
/**
 根据比例改变大小
 
 @param scale 比例
 */
- (void)cll_scaleBy:(CGFloat)scale;
/**
 在不改变原来宽高比例的情况下，适配新的大小

 @param aSize 新的大小
 */
- (void)cll_fitInSize:(CGSize)aSize;
@end
