//
//  CLLNavigationController.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CLLNavigationController : UINavigationController

+ (instancetype)navigationWithRootControllerClass:(Class)aClass block:(void(^ _Nullable)(UIViewController *rootVc))block;

@end
NS_ASSUME_NONNULL_END
