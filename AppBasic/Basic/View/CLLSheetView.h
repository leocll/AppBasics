//
//  CLLSheetView.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CLLSheetView;
@protocol SheetOptionsViewDelegate <NSObject>

/**
 选中行时执行
 */
- (void)didSelectedOnOptionsView:(CLLSheetView *)view;

@end

@interface CLLSheetView : UIView

/**标题*/
@property (nonatomic, strong) NSString *title;
/**数据源*/
@property (nonatomic, strong, readonly) NSArray <NSString *>*textArray;
/**当前选择的文案*/
@property (nonatomic, strong, readonly) NSString *selectedText;
/**当前被中的索引*/
@property (nonatomic, assign, readonly) NSInteger selectedIndex;
/**代理*/
@property (nonatomic, weak) id<SheetOptionsViewDelegate> delegate;
/**选中行的回调*/
@property (nonatomic, strong) void(^selectedBlock)(CLLSheetView *sheetView);
/**是否垂直可以滑动，默认可以*/
@property (nonatomic, assign) BOOL alwaysBounceVertical;

/**
 快速创建
 */
+ (instancetype)sheetWithTitle:(NSString *_Nullable)title textArray:(NSArray <NSString *>*)textArray selectedText:(NSString *_Nullable)selectedText;

/**
 快速创建
 */
+ (instancetype)sheetWithTitle:(NSString *_Nullable)title textArray:(NSArray <NSString *>*)textArray selectedText:(NSString *_Nullable)selectedText selectedBlock:(void(^)(CLLSheetView *sheet))block;

- (void)configTextArray:(NSArray <NSString *>*)textArray selectedText:(NSString *)selectedText;

/**
 显示
 */
- (void)show;

/**
 移除
 */
- (void)diss;

@end
NS_ASSUME_NONNULL_END
