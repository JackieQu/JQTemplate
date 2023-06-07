//
//  UIBarButtonItem+Extension.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)hColor target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:hColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:kFontSize];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:btn];
}

+ (instancetype)itemWithTitle:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)hColor target:(id)target action:(SEL)action {
    
    return [[UIBarButtonItem alloc] initWithTitle:title color:color highlightedColor:hColor target:target action:action];
}

- (instancetype)initWithImageName:(NSString *)imageName highlightedImageName:(NSString *)hImageName target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hImageName] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:kFontSize];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:btn];
}

+ (instancetype)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)hImageName target:(id)target action:(SEL)action {
    
    return [[UIBarButtonItem alloc] initWithImageName:imageName highlightedImageName:hImageName target:target action:action];
}

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    
    return [self initWithTitle:title color:kNormalColor highlightedColor:kHighlightedColor target:target action:action];
}

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    
    return [[UIBarButtonItem alloc] initWithTitle:title target:target action:action];
}

@end
