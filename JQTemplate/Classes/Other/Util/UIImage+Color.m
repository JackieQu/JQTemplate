//
//  UIImage+Color.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

#pragma mark - color

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect frame = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
