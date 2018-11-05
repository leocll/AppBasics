//
//  CLLAlertView.h
//  AppBasic
//
//  Created by admin on 2018/11/5.
//  Copyright © 2018年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLLAlertView : UIView
/**标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/**内容*/
@property (nonatomic, strong) UILabel *contentLabel;
/**左按钮*/
@property (nonatomic, strong) UIButton *leftBtn;
/**右按钮*/
@property (nonatomic, strong) UIButton *rightBtn;

+ (instancetype)alertWithTitle:(NSString * _Nullable)title content:(NSString *)content leftTitle:(NSString *)leftTitle leftAction:(void(^_Nullable)(CLLAlertView *alert))leftAction rightTitle:(NSString * _Nullable)rightTitle rightAction:(void(^_Nullable)(CLLAlertView *alert))rightAction;

- (void)show;
@end

NS_ASSUME_NONNULL_END
