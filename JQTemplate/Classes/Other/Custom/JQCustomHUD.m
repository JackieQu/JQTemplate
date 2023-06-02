//
//  JQCustomHUD.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/2.
//

#import "JQCustomHUD.h"

@interface JQCustomHUD ()

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UIView *hudView;

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) CGFloat hudWidth;

@end

@implementation JQCustomHUD

- (UIView *)maskView {
    
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor clearColor];
    }
    return _maskView;
}

- (UIView *)hudView {
    
    if (!_hudView) {
        _hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.hudWidth, self.hudWidth)];
        _hudView.center = self.center;
        _hudView.clipsToBounds = YES;
        _hudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _hudView.hidden = YES;
        _hudView.layer.masksToBounds = YES;
        _hudView.layer.cornerRadius = ADAPT_VALUE(10);
        
        [_hudView addSubview:self.indicator];
        [_hudView addSubview:self.titleLabel];
    }
    return _hudView;
}

- (UIActivityIndicatorView *)indicator {
    
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        _indicator.center = CGPointMake(self.hudWidth / 2, self.hudWidth / 2 - ADAPT_VALUE(10));
        _indicator.color = [UIColor whiteColor];
        _indicator.hidesWhenStopped = YES;
    }
    return _indicator;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.hudWidth / 2 + ADAPT_VALUE(10), self.hudWidth, ADAPT_VALUE(20))];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)setNeedMask:(BOOL)needMask {
    _needMask = needMask;
    
    if (!_needMask) {
        [self.maskView removeFromSuperview];
        self.bounds = self.hudView.frame;
    }
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.needMask = YES;
        self.hudWidth = ADAPT_VALUE(100);
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubview:self.maskView];
        [self addSubview:self.hudView];
    }
    return self;
}

- (void)show {
    
    [[UIApplication sharedApplication].windows.firstObject addSubview:self];
    
    self.hudView.hidden = NO;
    [self.indicator startAnimating];
}

- (void)dismiss {
    
    [self.indicator stopAnimating];
    self.hudView.hidden = YES;
    
    [self removeFromSuperview];
}

@end
