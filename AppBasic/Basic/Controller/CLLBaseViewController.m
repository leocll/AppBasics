 //
 //  CLLBaseViewController.h
 //  AppBasic
 //
 //  Created by leocll on 2017/9/6.
 //  Copyright © 2017年 leocll. All rights reserved.
 //

#import "CLLBaseViewController.h"
#import "CLLCommonDefinition.h"

@interface CLLBaseViewController ()
/**底部边缘视图*/
@property (nonatomic, strong) UIView *bottomMarginView;
@end

@implementation CLLBaseViewController

#pragma mark ----------------------------- 生命周期 ------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(200, 200, 200);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    // 初始化导航栏
    if (self.navigationController) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 0, 44, 44)];
        [backBtn setImage:NAMED_IMAGE(@"global_leftBackBlack") forState:UIControlStateNormal];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -22, 0, 0);
        [backBtn addTarget:self action:@selector(touchesBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - 点击返回
- (void)touchesBack {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter
- (UIView *)bottomMarginView {
    if (!_bottomMarginView) {
        CGRect frame = CGRectMake(0, kScreenHeight-kSafeBottomMargin, kScreenWidth, kSafeBottomMargin);
        _bottomMarginView = [[UIView alloc] initWithFrame:frame];
        [self.view insertSubview:_bottomMarginView atIndex:0];
    }
    return _bottomMarginView;
}

@end
