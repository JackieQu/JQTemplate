//
//  UITabBar+Badge.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "UITabBar+Badge.h"

@implementation UITabBar (Badge)

- (void)showBadgeAtIndex:(int)index {
   
    if (index >= self.items.count) {
        return;
    }
    
    [self removeBadgeAtIndex:index];
    [self addBadgeAtIndex:index];
}

- (void)addBadgeAtIndex:(int)index {
    
    UIView *badgeView = [[UIView alloc] initWithFrame:self.frame];
    badgeView.tag = 10000 + index;
    badgeView.backgroundColor = [UIColor redColor];
    float percentX = (index + 0.6) / self.items.count;
    CGFloat x = ceil(self.frame.size.width * percentX);
    CGFloat y = ceil(self.frame.size.height * 0.1);
    badgeView.frame = CGRectMake(x, y, 8, 8);
    badgeView.clipsToBounds = YES;
    badgeView.layer.masksToBounds = YES;
    badgeView.layer.cornerRadius = badgeView.frame.size.width / 2;
    [self addSubview:badgeView];
}

- (void)hideBedgeAtIndex:(int)index {
   
    if (index >= self.items.count) {
        return;
    }
    
    [self removeBadgeAtIndex:index];
}

- (void)removeBadgeAtIndex:(int)index {
   
    for (UIView *subview in self.subviews) {
        if (subview.tag == 10000 + index) {
            [subview removeFromSuperview];
        }
    }
}

@end
