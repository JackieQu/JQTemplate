//
//  UIImageView+GIF.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "UIImageView+GIF.h"

@implementation UIImageView (GIF)

#pragma mark - gif

+ (UIImageView *)gifImageViewWithFrame:(CGRect)frame contentsOfFile:(NSString *)path {
    
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval interval = 0.0f;
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    CGImageSourceRef isrc = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    if (isrc) {
        size_t count = CGImageSourceGetCount(isrc);
        images = [NSMutableArray arrayWithCapacity:count];
        
        for (size_t i = 0; i < count; i ++) {
            NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(isrc, i, NULL);
            NSDictionary *gifDict = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [gifDict objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            interval += delayTime.doubleValue;
        
            CGImageRef image = CGImageSourceCreateImageAtIndex(isrc, i, NULL);
            if (image) {
                [images addObject:[UIImage imageWithCGImage:image]];
                CGImageRelease(image);
            }
        }
        CFRelease(isrc);
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if (images.count) {
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setImage:[images objectAtIndex:0]];
        [imageView setAnimationImages:images];
        [imageView setAnimationDuration:interval];
        [imageView startAnimating];
    }
    return imageView;
}

@end
