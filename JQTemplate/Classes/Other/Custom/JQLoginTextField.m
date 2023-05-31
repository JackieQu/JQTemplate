//
//  JQLoginTextField.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import "JQLoginTextField.h"

@interface JQLoginTextField ()

@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation JQLoginTextField

- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 45, 35)];
        _leftImageView.backgroundColor = [UIColor clearColor];
        _leftImageView.contentMode = UIViewContentModeCenter;
    }
    return _leftImageView;
}

- (void)setLeftImageName:(NSString *)leftImageName {
    _leftImageName = leftImageName;
    
    self.leftImageView.image = [UIImage imageNamed:_leftImageName];
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
        self.leftView = self.leftImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.returnKeyType = UIReturnKeyDone;
    }
    return self;
}

@end
