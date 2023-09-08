//
//  UITabBar+Badge.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "UITabBar+Badge.h"

@implementation UITabBar (Badge)

- (void)showBadgeAtIndex:(NSInteger)index {
   
    if (index >= self.items.count) {
        return;
    }
    
    [self removeBadgeAtIndex:index];
    [self addBadgeAtIndex:index];
}

- (void)addBadgeAtIndex:(NSInteger)index {
    
    UIView *badgeView = [[UIView alloc] initWithFrame:self.frame];
    badgeView.tag = 10000 + index;
    badgeView.backgroundColor = [UIColor redColor];
    float percentX = (index + 0.6) / self.items.count;
    CGFloat x = ceil(self.frame.size.width * percentX);
    badgeView.frame = CGRectMake(x, 2, 8, 8);
    badgeView.clipsToBounds = YES;
    badgeView.layer.masksToBounds = YES;
    badgeView.layer.cornerRadius = badgeView.frame.size.width / 2;
    [self addSubview:badgeView];
}

- (void)hideBedgeAtIndex:(NSInteger)index {
   
    if (index >= self.items.count) {
        return;
    }
    
    [self removeBadgeAtIndex:index];
}

- (void)removeBadgeAtIndex:(NSInteger)index {
   
    for (UIView *subview in self.subviews) {
        if (subview.tag == 10000 + index) {
            [subview removeFromSuperview];
        }
    }
}

@end
