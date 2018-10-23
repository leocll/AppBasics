//
//  CLLVerticalContentView.m
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//


#import "CLLVerticalContentView.h"
#import "CLLVerticalContentView.h"
#import "UIView+CLLFrame.h"
#import <objc/runtime.h>

static char indexKey;
static char verMarginKey;
@implementation UIView (Priority)
- (NSNumber *)index {
    return objc_getAssociatedObject(self, &indexKey);
}

- (void)setIndex:(NSNumber *)index {
    objc_setAssociatedObject(self, &indexKey, index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)verMargin {
    NSNumber *num = objc_getAssociatedObject(self, &verMarginKey);
    return num==nil ? 0 : [num floatValue];
}

- (void)setVerMargin:(CGFloat)verMargin {
    objc_setAssociatedObject(self, &verMarginKey, [NSNumber numberWithFloat:verMargin], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@interface CLLVerticalContentView ()
/**滚动视图*/
@property (nonatomic, strong) UIScrollView *scrollView;
/**容器视图*/
@property (nonatomic, strong) UIView *contentView;
@end

@implementation CLLVerticalContentView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.scrollEnabled = YES;
        self.scrollView.alwaysBounceVertical = YES;
        if (@available(iOS 11.0, *)) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self addSubview:self.scrollView];
        
        self.contentView = [[UIView alloc] initWithFrame:self.scrollView.bounds];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:self.contentView];
    }
    return self;
}

#pragma mark - 重新布局子视图
- (void)relayoutSubviews {
    //先按index排序
    NSArray<UIView *> *sortedViews = [self.contentView.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
        if ([view1.index floatValue] > [view2.index floatValue]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    CGFloat y = self.topMargin;
    //逐个重新布局
    for (NSUInteger n = 0; n < sortedViews.count; n++) {
        UIView *view = [sortedViews objectAtIndex:n];
        if (view.hidden || view.height == 0) {
            continue;
        }
        view.top = y;
        CGFloat verMargin = view.verMargin==0 ? self.verMargin : view.verMargin;
        y = view.bottom+(n==sortedViews.count-1 ? 0 : verMargin);
    }
    y += self.bottomMargin;
    //调整容器的高度
    self.contentView.height = y;
    self.scrollView.height = self.height;
    self.scrollView.contentSize = CGSizeMake(self.width, y);
}

#pragma mark - 添加视图
- (void)addSubview:(UIView *)view withIndex:(NSNumber *)index {
    view.index = index;
    [self.contentView addSubview:view];
}

#pragma mark - setter
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width,self.scrollView.contentSize.height);
    self.contentView.width = self.scrollView.width;
}

- (void)setAlwaysBounceVertical:(BOOL)alwaysBounceVertical {
    self.scrollView.alwaysBounceVertical = alwaysBounceVertical;
}

#pragma mark - getter
- (BOOL)alwaysBounceVertical {
    return self.scrollView.alwaysBounceVertical;
}
@end
