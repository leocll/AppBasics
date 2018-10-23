//
//  CLLHud.m
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import "CLLHud.h"

static NSTimeInterval toastDefaultTime = 2; // toast默认显示时间

@implementation CLLHud

#pragma mark - 创建MB

/**
 内部使用的方法   创建MB
 
 @param message  文案
 @param view 传入的视图 为nil 默认在window上
 @return MB
 */
+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message view:(UIView *)view completion:(HFTHudCompletion _Nullable)completion {
    if (view == nil) {
        view = (UIView*)[UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelFont = [UIFont systemFontOfSize:15];
    hud.minSize = CGSizeMake(100, 100);
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
    hud.completionBlock = completion;
    return hud;
}

+ (void)setDefualtShowTime:(NSTimeInterval)time {
    toastDefaultTime = time;
}

#pragma mark-------------------- show Tip----------------------------

+ (MBProgressHUD *)showTipMessage:(NSString *)message {
    return [self commomShowTipMessage:message view:nil time:toastDefaultTime animated:YES completion:nil];
}

+ (MBProgressHUD *)showTipMessage:(NSString *)message to:(UIView *)view animated:(BOOL)annimated {
    return [self commomShowTipMessage:message view:view time:toastDefaultTime animated:annimated completion:nil];
}

+ (MBProgressHUD *)showTipMessage:(NSString *)message to:(UIView *)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion {
    return [self commomShowTipMessage:message view:nil time:time animated:annimated completion:completion];
}

+ (MBProgressHUD *)commomShowTipMessage:(NSString *)message view:(UIView *)view time:(NSTimeInterval)aTime animated:(BOOL)annimated  completion:(HFTHudCompletion _Nullable)completion {
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message view:view completion:completion];
    hud.minSize = CGSizeZero;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message?message:@"     ";
    [hud hide:annimated afterDelay:aTime];
    return hud;
}

#pragma mark-------------------- show Activity----------------------------

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message to:(UIView *)view animated:(BOOL)annimated {
    return [self commonShowActivityMessage:message view:view time:0 animated:annimated];
}

+ (MBProgressHUD *)showLoadingTo:(UIView *)view animated:(BOOL)annimated {
    return [self commonShowActivityMessage:@"加载中" view:view time:0 animated:annimated];
}

+ (MBProgressHUD *)commonShowActivityMessage:(NSString*)message view:(UIView *)view time:(NSTimeInterval)aTime animated:(BOOL)annimated {
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message view:view completion:nil];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message?message:@"加载中";
    if (aTime>0) {
        [hud hide:YES afterDelay:aTime];
    }
    return hud;
}


#pragma mark-------------------- show Image----------------------------
// Success
+ (MBProgressHUD *)showSuccessMessage:(NSString *)message {
    return [self showSuccessMessage:message to:nil animated:YES];
}

+ (MBProgressHUD *)showSuccessMessage:(NSString *)message to:(UIView *)view animated:(BOOL)annimated {
    return [self showSuccessMessage:message to:view time:toastDefaultTime animated:annimated completion:nil];
}

+ (MBProgressHUD *)showSuccessMessage:(NSString *)message to:(UIView *)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion {
    NSString *name =@"CLLHudResources.bundle/MBProgressHUD/MBHUD_Success";
    return [self commonShowCustomIcon:name message:message view:view time:toastDefaultTime animated:annimated completion:completion];
}

// Error
+ (MBProgressHUD *)showErrorMessage:(NSString *)message {
    return [self showErrorMessage:message to:nil animated:YES];
}

+ (MBProgressHUD *)showErrorMessage:(NSString *)message to:(UIView *)view animated:(BOOL)annimated {
    return [self showErrorMessage:message to:view time:toastDefaultTime animated:annimated completion:nil];
}

+ (MBProgressHUD *)showErrorMessage:(NSString *)message to:(UIView * _Nullable)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion {
    NSString *name =@"CLLHudResources.bundle/MBProgressHUD/MBHUD_Warn";
    return [self commonShowCustomIcon:name message:message view:view time:time animated:annimated completion:completion];
}

// Info
+ (MBProgressHUD *)showInfoMessage:(NSString *)message {
    return [self showInfoMessage:message to:nil animated:YES];
}

+ (MBProgressHUD *)showInfoMessage:(NSString *)message to:(UIView *)view animated:(BOOL)annimated {
    return [self showInfoMessage:message to:view time:toastDefaultTime animated:annimated completion:nil];
}

+ (MBProgressHUD *)showInfoMessage:(NSString *)message to:(UIView *)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion{
    NSString *name =@"CLLHudResources.bundle/MBProgressHUD/MBHUD_Info";
    return [self commonShowCustomIcon:name message:message view:view time:time animated:annimated completion:completion];
}

// warning
+ (MBProgressHUD *)showWarnMessage:(NSString *)message {
    return [self showWarnMessage:message to:nil animated:YES];
}

+ (MBProgressHUD *)showWarnMessage:(NSString *)message to:(UIView *)view animated:(BOOL)annimated {
    return [self showWarnMessage:message to:view time:toastDefaultTime animated:annimated completion:nil];
}

+ (MBProgressHUD *)showWarnMessage:(NSString *)message to:(UIView * _Nullable)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion {
    NSString *name =@"CLLHudResources.bundle/MBProgressHUD/MBHUD_Warn";
    return [self commonShowCustomIcon:name message:message view:view time:time animated:annimated completion:completion];
}

// custom
+ (MBProgressHUD *)showCustomIcon:(NSString *)iconName message:(NSString *)message {
    return [self showCustomIcon:iconName message:message to:nil time:toastDefaultTime animated:YES completion:nil];
}

+ (MBProgressHUD *)showCustomIcon:(NSString *)iconName message:(NSString *)message to:(UIView *)view time:(NSTimeInterval)time animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion {
    return [self commonShowCustomIcon:iconName message:message view:view time:time animated:annimated completion:completion];
}

+ (MBProgressHUD *)commonShowCustomIcon:(NSString *)iconName message:(NSString *)message view:(UIView *)view time:(NSTimeInterval)aTime animated:(BOOL)annimated completion:(HFTHudCompletion _Nullable)completion {
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message view:view completion:completion];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = message?message:@"    ";
    [hud hide:YES afterDelay:aTime];
    return hud;
}


+ (void)hideHUDForView:(UIView *)view animated:(BOOL)annimated {
    if (view == nil) {
        UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
        [MBProgressHUD hideAllHUDsForView:winView animated:annimated];
        return;
    }
    [MBProgressHUD hideAllHUDsForView:view animated:annimated];
}

+ (void)hideHUDForView:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

//#pragma mark - 清除所有的hud
//+ (void)hideAllHud {
//    [self hideHUDForView:nil]; // 清除window上的
//    UIViewController *currentVC = [CLLHud getCurrentUIVC];
//    [self recursionHideAllHudForView:currentVC.view]; // 清除当前控制器view上的hud 包括子上面的视图的所有
//    // 存在控制器有子视图控制器的情况
//    NSArray *childVCs = currentVC.childViewControllers;
//    for (UIViewController *childVC in childVCs) {
//        [self recursionHideAllHudForView:childVC.view];
//    }
//}
//
//#pragma mark - 递归搞事情
//+ (void)recursionHideAllHudForView:(UIView *)view {
//    NSArray *views = view.subviews;
//    for (UIView *view in views) {
//        if ([view isKindOfClass:[MBProgressHUD class]]) {
//            MBProgressHUD *hud = (MBProgressHUD *)view;
//            hud.removeFromSuperViewOnHide = YES;
//            [hud hide:NO];
//        } else {
//            [self recursionHideAllHudForView:view];
//        }
//    }
//}
//
///**常规写法*/
//+ (UIViewController *)getCurrentUIVC {
//    return [self getCurrentVC];
//}
//
//+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
//    UIViewController *currentVC;
//    if ([rootVC presentedViewController]) {
//        // 视图是被presented出来的
//        rootVC = [self getCurrentVCFrom:[rootVC presentedViewController]];
//    }
//    if ([rootVC isKindOfClass:[UITabBarController class]]) {
//        // 根视图为UITabBarController
//        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
//    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
//        // 根视图为UINavigationController
//        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
//    } else {
//        // 根视图为非导航类
//        currentVC = rootVC;
//    }
//    return currentVC;
//}
//
////获取当前屏幕显示的viewcontroller
//+ (UIViewController *)getCurrentVC {
//    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
//    
//    return currentVC;
//}


@end
