//
//  CLLHud.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^HFTHudCompletion)(void);

@interface CLLHud : NSObject

/**全局设置默认显示时长 deflaut 2s */
+ (void)setDefualtShowTime:(NSTimeInterval)time;


#pragma mark - 文本提示
/**快捷显示在window上*/
+ (MBProgressHUD *)showTipMessage:(NSString *_Nullable)message;
+ (MBProgressHUD *)showTipMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view animated:(BOOL)annimated;
+ (MBProgressHUD *)showTipMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion;

#pragma mark - 转圈加载提示
+ (MBProgressHUD *)showLoadingTo:(UIView *_Nullable)view animated:(BOOL)annimated;
+ (MBProgressHUD *)showLoadingMessage:(NSString* _Nullable)message to:(UIView *_Nullable)view animated:(BOOL)annimated;

#pragma mark - 默认图片提示
/**快捷显示在window上*/
+ (MBProgressHUD *)showSuccessMessage:(NSString *_Nullable)message;
+ (MBProgressHUD *)showSuccessMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view animated:(BOOL)annimated;
+ (MBProgressHUD *)showSuccessMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion;

/**快捷显示在window上*/
+ (MBProgressHUD *)showErrorMessage:(NSString *_Nullable)message;
+ (MBProgressHUD *)showErrorMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view animated:(BOOL)annimated;
+ (MBProgressHUD *)showErrorMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion;

/**快捷显示在window上*/
+ (MBProgressHUD *)showInfoMessage:(NSString *_Nullable)message;
+ (MBProgressHUD *)showInfoMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view animated:(BOOL)annimated;
+ (MBProgressHUD *)showInfoMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion;

/**快捷显示在window上*/
+ (MBProgressHUD *)showWarnMessage:(NSString *_Nullable)message;
+ (MBProgressHUD *)showWarnMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view animated:(BOOL)annimated;
+ (MBProgressHUD *)showWarnMessage:(NSString *_Nullable)message to:(UIView *_Nullable)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion;

#pragma mark - 自定义图片显示
/**快捷显示在window上*/
+ (MBProgressHUD *)showCustomIcon:(NSString *)iconName message:(NSString *_Nullable)message;
+ (MBProgressHUD *)showCustomIcon:(NSString *)iconName message:(NSString *_Nullable)message to:(UIView *_Nullable)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion;

+ (void)hideHUDForView:(UIView *_Nullable)view animated:(BOOL)annimated;
+ (void)hideHUDForView:(UIView *_Nullable)view;
/**会遍历所有的view清除hud （效率低 不推荐使用,除非不知道hud到底在哪个view上）*/
//+ (void)hideAllHud;

@end

NS_ASSUME_NONNULL_END
