//
//  CLLAlbumHelper.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ChoseImageBlcok)(UIImage  * _Nullable image);

@interface CLLAlbumHelper : NSObject

/**导航栏颜色定制*/
@property (nonatomic, strong) UIColor *navBgColor;
@property (nonatomic, strong) UIColor *naviTitleColor;
@property (nonatomic, strong) UIFont *naviTitleFont;
@property (nonatomic, strong) UIColor *barItemTextColor;
@property (nonatomic, strong) UIFont *barItemTextFont;

/**是否调用前置 默认NO*/
@property (nonatomic, assign) BOOL isFrontCamera;
/**相机是否允许编辑 默认NO*/
@property (nonatomic, assign) BOOL allowsEditingForCamera;
/**系统选取照片是否允许编辑 默认NO*/
@property (nonatomic, assign) BOOL allowsEditingForPhoto;

/**
 判断是否有相机功能
 */
+ (BOOL)isCameraAvailable;

#pragma mark - 拍摄 和 相册
/**
 显示，默认显示 @"拍摄", @"从相册选择"
 */
- (void)show;

#pragma mark - 单个
/**
 显示，只能 拍摄
 */
- (void)showOnlyTakePhoto;

/**
 显示，只能 从相册选择
 */
- (void)showOnlyChoosePhoto;

#pragma mark - 回调
/**
 绑定选中图片回调 单选
 
 @param block ChoseImageBlcok
 */
- (void)bindChoseImageBlcok:(nullable ChoseImageBlcok)block;

@end

NS_ASSUME_NONNULL_END
