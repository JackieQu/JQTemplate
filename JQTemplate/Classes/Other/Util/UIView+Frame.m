//
//  UIView+Frame.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - frame

- (CGPoint)origin {
    
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - origin

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)top {
    
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)left {
    
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

#pragma mark - size

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - center

- (CGFloat)centerX {
    
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark - random

+ (CGPoint)randomOrigin {
    
    return CGPointMake(arc4random() % (int)[UIScreen mainScreen].bounds.size.width, arc4random() % (int)[UIScreen mainScreen].bounds.size.height);
}

+ (CGSize)randomSizeWithMinValue:(NSInteger)min maxValue:(NSInteger)max {
    
    [self checkParameterWithMinValue:min maxValue:max];
    
    int w = arc4random() % max;
    w = w < min ? (int)min : w;
    int h = arc4random() % max;
    h = h < min ? (int)min : h;
    return CGSizeMake(w, h);
}

+ (CGRect)randomFrameWithMinValue:(NSInteger)min maxValue:(NSInteger)max {
    
    [self checkParameterWithMinValue:min maxValue:max];
    
    return (CGRect){[self randomOrigin], [self randomSizeWithMinValue:min maxValue:max]};
}

+ (void)checkParameterWithMinValue:(NSInteger)min maxValue:(NSInteger)max {
    
    if (min < 0 || max < 0) {
        @throw [NSException exceptionWithName:@"InvalidParameterException" reason:@"参数不能为负数" userInfo:nil];
    } else if (min > max) {
        @throw [NSException exceptionWithName:@"InvalidParameterException" reason:@"参数不符合规则" userInfo:nil];
    }
}

@end
