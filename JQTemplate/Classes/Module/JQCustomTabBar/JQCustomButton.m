//
//  JQCustomButton.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import "JQCustomButton.h"

static const CGFloat kScale = 0.618;

@implementation JQCustomButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat pointY = contentRect.size.height * kScale;
    CGFloat width  = contentRect.size.width;
    CGFloat height = contentRect.size.height * (1 - kScale);
    return CGRectMake(0, pointY, width, height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat width  = contentRect.size.width;
    CGFloat height = contentRect.size.height * kScale;
    return CGRectMake(0, 0, width, height);
}

@end
