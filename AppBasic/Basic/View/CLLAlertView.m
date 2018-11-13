//
//  CLLAlertView.m
//  AppBasic
//
//  Created by admin on 2018/11/5.
//  Copyright © 2018年 leocll. All rights reserved.
//

#import "CLLAlertView.h"
#import "CLLCommonDefinition.h"
#import "UIView+CLLFrame.h"
#import "CLLViewTool.h"

@interface CLLAlertView()
/**背景视图*/
@property (nonatomic, strong) UIView *bgView;
/**标题*/
@property (nonatomic, strong) NSString *title;
/**内容*/
@property (nonatomic, strong) NSString *content;
/**左按钮*/
@property (nonatomic, strong) NSString *leftTitle;
/**左按钮事件*/
@property (nonatomic, strong) void(^leftAction)(CLLAlertView *alert);
/**右按钮*/
@property (nonatomic, strong) NSString *rightTitle;
/**右按钮事件*/
@property (nonatomic, strong) void(^rightAction)(CLLAlertView *alert);
@end

@implementation CLLAlertView

+ (instancetype)alertWithTitle:(NSString *)title content:(NSString *)content leftTitle:(NSString *)leftTitle leftAction:(void (^)(CLLAlertView * _Nonnull))leftAction rightTitle:(NSString *)rightTitle rightAction:(void (^)(CLLAlertView * _Nonnull))rightAction {
    CLLAlertView *view = [[CLLAlertView alloc] init];
    view.title = title;
    view.content = content;
    view.leftTitle = leftTitle;
    view.leftAction = leftAction;
    view.rightTitle = rightTitle;
    view.rightAction = rightAction;
    [view createUI];
    return view;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    self.width = 375 * kLMSScreenFit(0.95, 0.85, 0.7);
    self.layer.cornerRadius = 4;
    __block CGFloat top = 0;
    // 标题
    if (self.title.length) {
        self.titleLabel = [CLLViewTool makeLabelWithFont:kFontSize6(15) textColor:RGB(52, 52, 52) block:^(UILabel * _Nonnull label) {
            label.text = self.title;
            label.textAlignment = NSTextAlignmentCenter;
            [label sizeToFit];
            label.top = 25;
            label.width = self.width;
            [self addSubview:label];
            top = label.bottom;
        }];
    }
    // 内容
    if (self.content.length) {
        self.contentLabel = [CLLViewTool makeLabelWithFont:kFontSize6(15) textColor:RGB(152, 152, 152) block:^(UILabel * _Nonnull label) {
            label.numberOfLines = 0;
            label.text = self.content;
            label.textAlignment = NSTextAlignmentCenter;
            label.left = kLMS(20, 15, 15);
            label.width = self.width - label.left * 2;
            label.height = [label sizeThatFits:CGSizeMake(label.width, MAXFLOAT)].height;
            label.top = top + 15;
            if (label.bottom < 100) {
                label.height = 100 - label.top;
            }
            [self addSubview:label];
            top = label.bottom;
        }];
    }
    // 左按钮
    self.leftBtn = [CLLViewTool makeButton:^(UIButton * _Nonnull btn) {
        btn.titleLabel.font = kFontSize6(15);
        [btn setTitle:self.leftTitle forState:UIControlStateNormal];
        [btn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchesLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        btn.height = 50;
        btn.width = self.rightTitle.length ? self.width*0.5 : self.width;
        btn.top = top;
        [self addSubview:btn];
    }];
    [self addSubview:[CLLViewTool makeHorizontalLine:^(UIView * _Nonnull line) {
        line.backgroundColor = RGB(230, 230, 230);
        line.width = self.width;
        line.height = 0.5;
        line.bottom = self.leftBtn.top;
    }]];
    // 右按钮
    if (self.rightTitle.length) {
        self.rightBtn = [CLLViewTool makeButton:^(UIButton * _Nonnull btn) {
            btn.titleLabel.font = kFontSize6(15);
            [btn setTitle:self.rightTitle forState:UIControlStateNormal];
            [btn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(touchesRightBtn) forControlEvents:UIControlEventTouchUpInside];
            btn.height = 50;
            btn.width = self.rightTitle.length ? self.width*0.5 : self.width;
            btn.top = top;
            btn.left = self.leftBtn.right;
            [self addSubview:btn];
        }];
        [self addSubview:[CLLViewTool makeVerticalLine:^(UIView * _Nonnull line) {
            line.backgroundColor = RGB(230, 230, 230);
            line.width = 0.5;
            line.height = self.leftBtn.height;
            line.top = self.leftBtn.top;
            line.centerX = self.width * 0.5;
        }]];
    }
    
    self.height = self.leftBtn.bottom;
}

- (void)touchesLeftBtn {
    [self hide];
    EXECUTE_BLOCK(self.leftAction,self);
}

- (void)touchesRightBtn {
    [self hide];
    EXECUTE_BLOCK(self.rightAction,self);
    
}

- (void)show {
    self.centerX = self.bgView.width * 0.5;
    self.centerY = self.bgView.height * 0.5;
    [KEY_WINDOW addSubview:self.bgView];
    [self.bgView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = RGBA(0, 0, 0, 0.3);
    }];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.03, 1.03, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.97, 0.97, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)hide {
    self.bgView.backgroundColor = RGBA(0, 0, 0, 0);
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:kScreenRect];
        _bgView.backgroundColor = RGBA(0, 0, 0, 0);
    }
    return _bgView;
}

@end
