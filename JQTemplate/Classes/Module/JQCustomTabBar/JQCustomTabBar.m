//
//  JQCustomTabBar.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "JQCustomTabBar.h"
#import "JQCustomTabBarButton.h"

@interface JQCustomTabBar ()

@property (nonatomic, strong, readwrite) JQTabBarModel *tabBarModel;
@property (nonatomic, strong) JQCustomTabBarButton *selectedBtn;
@property (nonatomic, strong) JQCustomTabBarButton *specialBtn;
@property (nonatomic, strong) UIView *markLineView;

@end

@implementation JQCustomTabBar

- (JQTabBarModel *)tabBarModel {
    
    if (!_tabBarModel) {
        _tabBarModel = [JQTabBarModel tabBarModel];
    }
    return _tabBarModel;
}

- (UIView *)markLineView {
    
    if (!_markLineView) {
        _markLineView = [[UIView alloc] initWithFrame:CGRectMake(0, -ADAPT_VALUE(2), ADAPT_VALUE(24), ADAPT_VALUE(2))];
        _markLineView.backgroundColor = [UIColor orangeColor];
        _markLineView.centerX = self.selectedBtn.centerX;
    }
    return _markLineView;
}

+ (JQCustomTabBar *)shared {
    
    static JQCustomTabBar *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor whiteColor];
        
        NSUInteger itemCount = self.tabBarModel.availableItems.count;
        CGFloat itemWidth = frame.size.width / itemCount;
        for (NSUInteger i = 0; i < itemCount; i ++) {
            JQTabBarItemModel *item = self.tabBarModel.availableItems[i];
            JQCustomTabBarButton *btn = [JQCustomTabBarButton buttonWithType:UIButtonTypeCustom];
            if (item.isSpecial) {
                btn.tag = kSpecialTag;
                btn.frame = CGRectMake(0, 0, 80, 80);
                btn.center = CGPointMake(itemWidth * i + itemWidth / 2, 0);
                self.specialBtn = btn;
            } else {
                btn.tag = JQCustomButtonDemo + i;
                btn.frame = CGRectMake(itemWidth * i, 0, itemWidth, self.frame.size.height);
            }
            btn.showsTouchWhenHighlighted = NO;
            btn.item = item;
            [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i == self.tabBarModel.selectedIndex) {
                btn.selected = YES;
                self.selectedBtn = btn;
            }
            [self addSubview:btn];
        }
        if (self.tabBarModel.isMarked) {
            [self addSubview:self.markLineView];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger itemCount = self.tabBarModel.availableItems.count;
    CGFloat itemWidth = self.frame.size.width / itemCount;
    for (UIView *subview in self.subviews) {
        if (!subview.tag) continue;
        
        NSUInteger i = subview.tag - JQCustomButtonDemo;
        if (subview.tag == kSpecialTag) {
            subview.center = CGPointMake(itemWidth * self.tabBarModel.specialIndex + itemWidth / 2, 0);
        } else {
            subview.frame = CGRectMake(itemWidth * i, 0, itemWidth, self.frame.size.height);
        }
    }
    
    if (self.tabBarModel.isMarked) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
            self.markLineView.frame = CGRectMake(0, -ADAPT_VALUE(2), ADAPT_VALUE(24), ADAPT_VALUE(2));
        } else if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            self.markLineView.frame = CGRectMake(0, -ADAPT_VALUE_HORIZONTAL(2), ADAPT_VALUE_HORIZONTAL(24), ADAPT_VALUE_HORIZONTAL(2));
        }
        self.markLineView.centerX = self.selectedBtn.centerX;
    }
    
    if (self.tabBarModel.specialItem) {
        [self bringSubviewToFront:self.specialBtn];
    }
}

- (void)clickAction:(JQCustomTabBarButton *)sender {
    
    BOOL isSpecial  = sender.tag == kSpecialTag;
    BOOL isMarked   = self.tabBarModel.isMarked && !isSpecial;
    BOOL isAnimated = self.tabBarModel.isAnimated; // && !isSpecial;
 
    if (![sender isEqual:self.selectedBtn] && !isSpecial) {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
    }
    
    if (isAnimated) {
        
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
            if (isMarked) {
                self.markLineView.width = ADAPT_VALUE(2);
                self.markLineView.centerX = sender.centerX;
            }
        } completion:^(BOOL finished) {
            sender.transform = CGAffineTransformIdentity;
            if (isMarked) {
                self.markLineView.width = ADAPT_VALUE(24);
                self.markLineView.centerX = sender.centerX;
            }
            [self handleAction:sender];
        }];
        
    } else {
        
        if (isMarked) {
            self.markLineView.centerX = sender.centerX;
        }
        [self handleAction:sender];
    }
}

- (void)handleAction:(JQCustomTabBarButton *)sender {
    
    NSInteger index = sender.tag == kSpecialTag ? kSpecialTag : sender.tag - JQCustomButtonDemo;
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedAtIndex:)]) {
        [self.delegate tabBar:self selectedAtIndex:index];
        return;
    }
    
    !self.block ? : self.block(self, index);
}

@end
