//
//  JQAlertView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import "JQAlertView.h"

@interface JQAlertView ()

@property (nonatomic, strong) UIControl *overLayer;

@end

@implementation JQAlertView

- (UIControl *)overLayer {
    
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _overLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
   
        // TODO
        CGFloat btnH = ADAPT_VALUE(40);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ADAPT_VALUE(STANDARD_MARGIN), ADAPT_VALUE(STANDARD_MARGIN), frame.size.width - ADAPT_VALUE(STANDARD_MARGIN) * 2, frame.size.height - btnH - ADAPT_VALUE(STANDARD_MARGIN) * 2)];
        label.text = @"这是提示";
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self addSubview:label];
        
        if (frame.size.height < btnH) {
            return self;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, frame.size.height - btnH, frame.size.width / 2, btnH);
        btn.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        btn.tag = 100;
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(CGRectGetMaxX(btn.frame), CGRectGetMinY(btn.frame), frame.size.width / 2, btnH);
        btn2.backgroundColor = [UIColor orangeColor];
        btn2.tag = 101;
        [btn2 setTitle:@"确认" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
    }
    return self;
}

- (void)clickAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(alertView:selectedAtIndex:)]) {
        [self.delegate alertView:self selectedAtIndex:sender.tag - 100];
    }
    
    [self dismiss];
}

- (void)show {
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] windows].firstObject;
    [keyWindow addSubview:self.overLayer];
    [keyWindow addSubview:self];
    
    self.center = self.overLayer.center;
    
    [self fadeIn];
}

- (void)dismiss {
    
    [self fadeOut];
}

- (void)fadeIn {
    
    self.overLayer.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)fadeOut {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
    }];
}

@end
