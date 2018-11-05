//
//  CLLSheetView.m
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import "CLLSheetView.h"
#import "CLLCommonDefinition.h"
#import "UIView+CLLFrame.h"

#define kCellHieght 45
#define kTextColor RGB(52,52,52)
#define kThemeColor kTextColor

static NSString *ident = @"cell";

@interface CLLSheetView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

/**标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/**数据源*/
@property (nonatomic, strong) NSArray <NSString *>*textArray;
/**当前选择的文案*/
@property (nonatomic, strong) NSString *selectedText;
/**列表*/
@property (nonatomic, strong) UITableView *tableView;
/**当前被选中行的索引*/
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/**蒙层*/
@property (nonatomic, strong) UIView *coverView;

@end

@implementation CLLSheetView

#pragma mark - 快速初始化
+ (instancetype)sheetWithTitle:(NSString *)title textArray:(NSArray<NSString *> *)textArray selectedText:(NSString *)selectedText {
	CLLSheetView *view = [[CLLSheetView alloc] initWithFrame:CGRectZero];
	view.title = title;
	[view configTextArray:textArray selectedText:selectedText];
	return view;
}

+ (instancetype)sheetWithTitle:(NSString *)title textArray:(NSArray<NSString *> *)textArray selectedText:(NSString *)selectedText selectedBlock:(void (^)(CLLSheetView * _Nonnull))block {
    CLLSheetView *view = [[CLLSheetView alloc] initWithFrame:CGRectZero];
    view.title = title;
    view.selectedBlock = block;
    [view configTextArray:textArray selectedText:selectedText];
    return view;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
	if (frame.size.width == 0) {
		frame.size = CGSizeMake(kScreenWidth, kScreenWidth);
	}
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化默认数据
        [self createDefaultData];
        // 初始化界面
        [self createUI];
    }
    return self;
}

#pragma mark - 初始化默认数据
- (void)createDefaultData {
    
}

#pragma mark - 初始化界面
- (void)createUI {
//    self.backgroundColor = [UIColor whiteColor];
	self.clipsToBounds = YES;
}

#pragma mark - 画标题Label
- (UILabel *)drawTitleLabel {
	UILabel *label = [UILabel new];
	label.textColor = kTextColor;
	label.textAlignment = NSTextAlignmentCenter;
	label.font = kFontSize6(15);
	label.width = self.width;
	label.height = kCellHieght;
	self.tableView.height = self.height-kCellHieght;
	self.tableView.top = label.bottom;
	[self addSubview:label];
	
	UIView *line = [[UIView alloc] initWithFrame:CGRectMake(label.left, label.bottom-0.5, label.width, 0.5)];
	line.backgroundColor = RGB(234, 234, 234);
	[self addSubview:line];
	return label;
}

#pragma mark - 画列表
- (UITableView *)drawTableView {
	UITableView *list = [[UITableView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom, self.width, self.height-self.titleLabel.height) style:UITableViewStylePlain];
	list.backgroundColor = [UIColor whiteColor];
	list.delegate = self;
	list.dataSource = self;
	list.separatorStyle = UITableViewCellSeparatorStyleNone;
    list.alwaysBounceVertical = YES;
	[list registerClass:[UITableViewCell class] forCellReuseIdentifier:ident];
	[self addSubview:list];
	return list;
}

#pragma mark - 配置数据源
- (void)configTextArray:(NSArray<NSString *> *)textArray selectedText:(NSString *)selectedText {
	self.textArray = textArray;
	self.selectedText = selectedText;
	for (int i = 0; i < self.textArray.count; i++) {
		if ([selectedText isEqualToString:self.textArray[i]]) {
			self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
			break;
		}
		if (i == self.self.textArray.count - 1) {
			self.selectedIndexPath = nil;
		}
	}
	[self.tableView reloadData];
	if (self.selectedIndexPath) {
		[self.tableView scrollToRowAtIndexPath:self.selectedIndexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
	}
}

#pragma mark - 显示
- (void)show {
	self.top = self.coverView.height;
	[self.coverView addSubview:self];
	[[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
	self.coverView.backgroundColor = [UIColor clearColor];
	[UIView animateWithDuration:0.3 animations:^{
		self.coverView.backgroundColor = RGBA(0, 0, 0, 0.4);
		self.bottom = self.coverView.height - kSafeBottomMargin;
	}];
}

#pragma mark - 移除
- (void)diss {
	[UIView animateWithDuration:0.3 animations:^{
		self.coverView.backgroundColor = [UIColor clearColor];
		self.top = self.coverView.height;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
		[self.coverView removeFromSuperview];
	}];
}

#pragma mark -------------- setter && getter --------------
#pragma mark - 设置标题
- (void)setTitle:(NSString *)title {
	_title = title;
	if (self.titleLabel == nil) {
		self.titleLabel = [self drawTitleLabel];
	}
	self.titleLabel.backgroundColor = title.length>0 ? [UIColor whiteColor] : [UIColor clearColor];
	self.titleLabel.text = title;
}

#pragma mark - 设置数据源
- (void)setTextArray:(NSArray<NSString *> *)textArray {
	_textArray = textArray;
	if (self.tableView == nil) {
		self.tableView = [self drawTableView];
	}
	self.tableView.height = kCellHieght*textArray.count > self.tableView.height ? self.tableView.height : kCellHieght*textArray.count;
	self.height = self.tableView.bottom;
}

- (void)setAlwaysBounceVertical:(BOOL)alwaysBounceVertical {
    self.tableView.alwaysBounceVertical = alwaysBounceVertical;
}

- (BOOL)alwaysBounceVertical {
    return self.tableView.alwaysBounceVertical;
}

#pragma mark - 被选中的索引
- (NSInteger)selectedIndex {
	return self.selectedIndexPath.row;
}

#pragma mark - 蒙层
- (UIView *)coverView {
	if (_coverView == nil) {
		_coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
		_coverView.backgroundColor = RGBA(0, 0, 0, 0.4);
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(diss)];
		tap.delegate = self;
		[_coverView addGestureRecognizer:tap];
	}
	return _coverView;
}

#pragma mark ----------------------------- UITableViewDelegate && UITableViewDataSource ------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kCellHieght;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	UILabel *label = [self labelForCell:cell];
	label.text = self.textArray[indexPath.row];
	if ([self selectedIndexPathIsEqual:indexPath]) {
		label.textColor = kThemeColor;
        label.font = kFontSize6(15);
	} else {
		label.textColor = kTextColor;
		label.font = kFontSize6(15);
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
	UILabel *label = [self labelForCell:cell];
	label.textColor = kTextColor;
	label.font = kFontSize6(15);
	
	cell = [tableView cellForRowAtIndexPath:indexPath];
	label = [self labelForCell:cell];
	label.textColor = kThemeColor;
    label.font = kFontSize6(15);
	
	self.selectedIndexPath = indexPath;
	self.selectedText = self.textArray[indexPath.row];
	if ([self.delegate respondsToSelector:@selector(didSelectedOnOptionsView:)]) {
		[self.delegate didSelectedOnOptionsView:self];
	}
    EXECUTE_BLOCK(self.selectedBlock,self);
}

#pragma mark -------------- 关于Cell --------------
#pragma mark - cell的label
- (UILabel *)labelForCell:(UITableViewCell *)cell {
	UILabel *label = [cell viewWithTag:23];
	if (label == nil) {
		label = [UILabel new];
		label.tag = 23;
		label.font = kFontSize6(15);
		label.textColor = [UIColor blackColor];
		label.textAlignment = NSTextAlignmentCenter;
		label.height = kCellHieght;
		label.width = self.width;
		[cell addSubview:label];
		// 底线
		UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, label.height-0.5, label.width, 0.5)];
		line.backgroundColor = RGB(234, 234, 234);
		[label addSubview:line];
	}
	return label;
}

#pragma mark - 是否未被选中的索引
- (BOOL)selectedIndexPathIsEqual:(NSIndexPath *)indexPath {
	if (self.selectedIndexPath == nil) {
		return NO;
	}
	return indexPath.section == self.selectedIndexPath.section && indexPath.row == self.selectedIndexPath.row;
}

#pragma mark -------------- gestureRecognizerShouldBegin --------------
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	if ([touch.view isDescendantOfView:self.tableView]) {
		return NO;
	}
	return YES;
}

@end
