//
//  CLLViewTool.m
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import "CLLViewTool.h"
#import "CLLCommonDefinition.h"
#import "UIView+CLLFrame.h"

@interface CLLLayoutButton : UIButton
/**布局回调*/
@property (nonatomic, strong) void(^layoutBlock)(UIButton *btn);
@end
@implementation CLLLayoutButton
- (void)layoutSubviews {
    [super layoutSubviews];
    EXECUTE_BLOCK(self.layoutBlock,self);
}
@end

@implementation CLLViewTool
+ (UILabel *)makeLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor block:(void (^)(UILabel *))block {
    static NSString *str = @"00";
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentLeft;
    label.height = [str sizeWithAttributes:@{NSFontAttributeName:font}].height;
    EXECUTE_BLOCK(block,label);
    return label;
}

+ (UIView *)makeVerticalLine:(void (^)(UIView *))block {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(249, 249, 249);
    line.width = 0.5;
    EXECUTE_BLOCK(block,line);
    return line;
}

+ (UIView *)makeHorizontalLine:(void (^)(UIView *))block {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(249, 249, 249);
    line.height = 0.5;
    EXECUTE_BLOCK(block,line);
    return line;
}

+ (UIButton *)makeButton:(void (^)(UIButton *))block {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    EXECUTE_BLOCK(block,btn);
    return btn;
}

+ (UIButton *)makeButton:(void (^)(UIButton *))block layout:(void (^)(UIButton *))layout {
    CLLLayoutButton *btn = [CLLLayoutButton buttonWithType:UIButtonTypeCustom];
    EXECUTE_BLOCK(block,btn);
    btn.layoutBlock = layout;
    return btn;
}

+ (UIImageView *)makeImageView:(UIImage *)image block:(void (^)(UIImageView *))block {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.size = image.size;
    EXECUTE_BLOCK(block,imageView);
    return imageView;
}

+ (UIImage *)makeImageFromView:(UIView *)view {
    if (!view) {return nil;}
    UIGraphicsBeginImageContextWithOptions(view.size, NO, [UIScreen mainScreen].scale);
    [[UIColor whiteColor] setFill];
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
