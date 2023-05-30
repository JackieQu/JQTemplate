//
//  UIImageView+GIF.h
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (GIF)

// gif

+ (UIImageView *)gifImageViewWithFrame:(CGRect)frame contentsOfFile:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
