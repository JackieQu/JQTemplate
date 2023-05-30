//
//  UIColor+Random.h
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Random)

// random

@property(class, nonatomic, readonly) UIColor *randomRGBAColor;
@property(class, nonatomic, readonly) UIColor *randomColor;

@end

NS_ASSUME_NONNULL_END
