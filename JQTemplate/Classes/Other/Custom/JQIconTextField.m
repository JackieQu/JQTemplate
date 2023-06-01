//
//  JQIconTextField.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import "JQIconTextField.h"

static CGFloat kIconWidth = 20.0f;
static CGFloat kLeftViewWidth = 30.0f;

@interface JQIconTextField ()

@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation JQIconTextField

- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kIconWidth, kIconWidth)];
        _leftImageView.contentMode = UIViewContentModeCenter;
    }
    return _leftImageView;
}

- (void)setLeftImageName:(NSString *)leftImageName {
    _leftImageName = leftImageName;
    
    UIImage *originalImage = [UIImage imageNamed:leftImageName];
    if (originalImage.size.width > kIconWidth || originalImage.size.height > kIconWidth) {
        CGFloat scale = MAX(originalImage.size.width / kIconWidth, originalImage.size.height / kIconWidth);
        UIImage *scaledImage = [UIImage imageWithCGImage:[originalImage CGImage]
                                                   scale:originalImage.scale * scale
                                             orientation:(originalImage.imageOrientation)];
        self.leftImageView.image = scaledImage;
    } else {
        self.leftImageView.image = originalImage;
    }
}

- (instancetype)initWithFrame:(CGRect)frame leftImageName:(NSString *)leftImageName {
    
    self.leftImageName = leftImageName;
    
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.clearsOnBeginEditing = NO;
        self.background = [UIImage imageNamed:@"login_tf_bg"];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        CGFloat width = frame.size.width > kLeftViewWidth ? kLeftViewWidth : frame.size.width;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        self.leftImageView.center = leftView.center;
        [leftView addSubview:self.leftImageView];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.returnKeyType = UIReturnKeyDone;
    }
    return self;
}

@end
