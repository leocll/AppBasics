//
//  CLLBaseViewController.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CLLBaseViewController : UIViewController
/**底部边缘视图*/
@property (nonatomic, strong, readonly) UIView *bottomMarginView;
/**
 点击返回的事件，子类可调用、可重写
 */
- (void)touchesBack;
@end
NS_ASSUME_NONNULL_END
