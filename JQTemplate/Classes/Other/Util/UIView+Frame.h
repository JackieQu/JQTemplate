//
//  UIView+Frame.h
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

// frame

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

// origin

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

// size

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

// center

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

// random

+ (CGPoint)randomOrigin;
+ (CGSize)randomSizeWithMinValue:(NSInteger)min maxValue:(NSInteger)max;
+ (CGRect)randomFrameWithMinValue:(NSInteger)min maxValue:(NSInteger)max;

@end

NS_ASSUME_NONNULL_END
