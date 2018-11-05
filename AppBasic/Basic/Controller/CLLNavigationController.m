//
//  CLLNavigationController.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import "CLLNavigationController.h"
#import "CLLCommonDefinition.h"

@interface CLLNavigationController ()<UINavigationControllerDelegate>

@end

@implementation CLLNavigationController

+ (instancetype)navigationWithRootControllerClass:(Class)aClass block:(void (^)(UIViewController *))block {
    id vc = [[aClass alloc] init];
    EXECUTE_BLOCK(block,vc);
    return [[CLLNavigationController alloc] initWithRootViewController:vc];
}

#pragma mark ----------------------------- 生命周期 ------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化默认数据
    [self createDefaultData];
    // 初始化界面
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

#pragma mark - 初始化默认数据
- (void)createDefaultData {
    
}

#pragma mark - 初始化界面
- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // 背景
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:NAME_IMAGE_IN_BUNDLE(@"navi_bg_64",self.class) forBarMetrics:0];
    // 去掉导航栏下面的线
    [bar setShadowImage:[UIImage new]];
    // title白色
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:bar.titleTextAttributes];
    [dic setValue:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [dic setValue:kFontSize6(17) forKey:NSFontAttributeName];
    bar.titleTextAttributes = dic;
    // 左右按钮颜色
    [bar setTintColor:RGB(51, 51, 51)];
}

#pragma mark ----------------------------- 其他方法 ------------------------------
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = (self.viewControllers.count >= 1);
    [super pushViewController:viewController animated:animated];
}

#pragma mark ----------------------------- 公用方法 ------------------------------

#pragma mark ----------------------------- 网络请求 ------------------------------

#pragma mark ----------------------------- 代理方法 ------------------------------

#pragma mark --------------------------- setter&getter -------------------------


@end
