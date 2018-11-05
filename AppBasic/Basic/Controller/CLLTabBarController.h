//
//  CLLTabBarController.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CLLTabBarController : UITabBarController
/**
 设置子项

 @param vc vc
 @param tabBarTitle title
 @param imageName 图片
 @param selectedImageName 被选中时的图片
 */
- (void)setupChildVC:(UIViewController *)vc tabBarTitle:(NSString *)tabBarTitle image:(UIImage *)image selectedImage:(UIImage *)selectedImage;
@end
NS_ASSUME_NONNULL_END
