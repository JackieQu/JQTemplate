//
//  JQDrawView.h
//  JQTemplate
//
//  Created by JackieQu on 2023/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQDrawView : UIView

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) UIColor *pathColor;

@property (nonatomic, strong) UIImage *image;

- (void)clear;

- (void)withdraw;

@end

NS_ASSUME_NONNULL_END
