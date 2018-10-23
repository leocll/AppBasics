//
//  CLLVerticalContentView.h
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIView (Priority)
/**优先级*/
@property (nonatomic, copy) NSNumber *index;
/**垂直间隙*/
@property (nonatomic, assign) CGFloat verMargin;
@end

@interface CLLVerticalContentView : UIView
/**上边缘，默认0*/
@property (nonatomic, assign) CGFloat topMargin;
/**下边缘，默认0*/
@property (nonatomic, assign) CGFloat bottomMargin;
/**垂直间隙，默认0*/
@property (nonatomic, assign) CGFloat verMargin;
/**是否始终保持垂直滑动，默认yes*/
@property (nonatomic, assign) BOOL alwaysBounceVertical;
/**滚动视图*/
@property (nonatomic, strong, readonly) UIScrollView *scrollView;

- (void)addSubview:(UIView *)view withIndex:(NSNumber *)index;

- (void)relayoutSubviews;

@end
NS_ASSUME_NONNULL_END
