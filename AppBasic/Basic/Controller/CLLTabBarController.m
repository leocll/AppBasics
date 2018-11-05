//
//  CLLTabBarController.m
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import "CLLTabBarController.h"
#import "CLLNavigationController.h"

@interface CLLTabBarController ()

@end

@implementation CLLTabBarController

#pragma mark ----------------------------- 生命周期 ------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化默认数据
    [self createDefaultData];
    // 初始化界面
    [self createUI];
}

#pragma mark - 初始化默认数据
- (void)createDefaultData {
    
}

#pragma mark - 初始化界面
- (void)createUI {
    // 初始化TabBar
    [self createTabBar];
}

#pragma mark - 初始化TabBar
- (void)createTabBar {
    
}

#pragma mark - 初始化子控制器
- (void)setupChildVC:(UIViewController *)vc tabBarTitle:(NSString *)tabBarTitle image:(nonnull UIImage *)image selectedImage:(nonnull UIImage *)selectedImage {
    vc.tabBarItem.title = tabBarTitle;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    CLLNavigationController *nav = [[CLLNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark ----------------------------- 私有方法 ------------------------------

#pragma mark ----------------------------- 公用方法 ------------------------------

#pragma mark ----------------------------- 网络请求 ------------------------------

#pragma mark ----------------------------- 代理方法 ------------------------------

#pragma mark --------------------------- setter&getter -------------------------


@end
