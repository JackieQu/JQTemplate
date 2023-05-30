//
//  UIColor+Random.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

#pragma mark - random

+ (UIColor *)randomRGBAColor {
    
    NSInteger r = arc4random() % 255;
    NSInteger g = arc4random() % 255;
    NSInteger b = arc4random() % 255;
    NSInteger a = arc4random() % 10;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:a / 10.0f];
}

+ (UIColor *)randomColor {
    
    NSInteger r = arc4random() % 255;
    NSInteger g = arc4random() % 255;
    NSInteger b = arc4random() % 255;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

@end
