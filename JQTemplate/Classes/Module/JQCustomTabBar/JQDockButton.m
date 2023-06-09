//
//  JQDockButton.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import "JQDockButton.h"

static const CGFloat kScale = 0.618;

@implementation JQDockButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat pointX = 0;
    CGFloat pointY = contentRect.size.height * kScale;
    CGFloat width  = contentRect.size.width;
    CGFloat height = contentRect.size.height * (1 - kScale);
    return CGRectMake(pointX, pointY, width, height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat pointX = 0;
    CGFloat pointY = 0;
    CGFloat width  = contentRect.size.width;
    CGFloat height = contentRect.size.height * kScale;
    return CGRectMake(pointX, pointY, width, height);
}

@end
