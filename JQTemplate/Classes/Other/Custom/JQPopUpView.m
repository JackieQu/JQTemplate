//
//  JQPopUpView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/2.
//

#import "JQPopUpView.h"

@interface JQPopUpView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JQPopUpView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
        [self addSubview:self.imageView];
        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = self.bounds;
    }
    return _imageView;
}

- (void)showWithImage:(UIImage *)image {
    
    self.imageView.image = image;
    self.hidden = NO;
    
    [UIView animateWithDuration:0.7 animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5 / (image.size.width / image.size.height));
    }];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.imageView.transform = CGAffineTransformIdentity;
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.alpha = 1;
        self.hidden = YES;
    }];
}

@end
