//
//  JQCustomTabBar.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "JQCustomTabBar.h"
#import "JQTabBarButton.h"

@interface JQCustomTabBar ()

@property (nonatomic, strong, readwrite) JQTabBarModel *tabBarModel;
@property (nonatomic, strong) JQTabBarButton *selectedBtn;
@property (nonatomic, strong) JQTabBarButton *specialBtn;
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

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor whiteColor];
        
        NSUInteger itemCount = self.tabBarModel.availableItems.count;
        CGFloat itemWidth = frame.size.width / itemCount;
        for (NSUInteger i = 0; i < itemCount; i ++) {
            JQTabBarItemModel *item = self.tabBarModel.availableItems[i];
            JQTabBarButton *btn = [JQTabBarButton buttonWithType:UIButtonTypeCustom];
            if (item.isSpecial) {
                btn.tag = kSpecialTag;
                btn.frame = CGRectMake(0, 0, 80, 80);
                btn.center = CGPointMake(itemWidth * i + itemWidth / 2, 0);
                self.specialBtn = btn;
            } else {
                btn.tag = i;
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
    
    if (self.tabBarModel.specialItem) {
        [self bringSubviewToFront: self.specialBtn];
    }
}

- (void)clickAction:(JQTabBarButton *)sender {
    
    BOOL isSpecial  = sender.tag == kSpecialTag;
    BOOL isMarked   = self.tabBarModel.isMarked && !isSpecial;
    BOOL isAnimated = self.tabBarModel.isAnimated;
 
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
    
    if (isSpecial) { return; }
    
    if (![sender isEqual:self.selectedBtn]) {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
    }
}

- (void)handleAction:(JQDockButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedAtIndex:)]) {
        [self.delegate tabBar:self selectedAtIndex:sender.tag];
        return;
    }
    
    !self.block ? : self.block(self, sender.tag);
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    
//    UIView *view = [super hitTest:point withEvent:event];
//    if (!view) {
//        CGPoint newPoint = [self.specialBtn convertPoint:point fromView:self];
//        if (CGRectContainsPoint(self.specialBtn.bounds, newPoint)) {
//            view = self.specialBtn;
//        }
//    }
//    return view;
//}

@end
