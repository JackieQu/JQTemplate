//
//  UITabBar+HitTest.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/8.
//

#import "UITabBar+HitTest.h"
#import "JQCustomTabBar.h"

@implementation UITabBar (HitTest)

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleMethod([self class], @selector(hitTest:withEvent:), @selector(my_hitTest:withEvent:));
    });
}

- (UIView *)my_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [self my_hitTest:point withEvent:event];
    if (view || ![JQCustomTabBar shared].tabBarModel.isSpecial) {
        return view;
    }
    
    if (![self canAnswerEvent:self]) {
        return nil;
    }
    
    for (NSInteger i = self.subviews.count - 1; i >= 0; i --) {
        UIView *firstLayerView = self.subviews[i];
        if (![self canAnswerEvent:firstLayerView]) {
            continue;
        }
        
        if ([firstLayerView isKindOfClass:[JQCustomTabBar class]] && !firstLayerView.superview.isHidden) {
            for (NSInteger j = firstLayerView.subviews.count - 1; j >= 0; j --) {
                UIView *secondLayerView = firstLayerView.subviews[j];
                CGPoint convertPoint = [secondLayerView convertPoint:point fromView:firstLayerView];
                if (CGRectContainsPoint(secondLayerView.bounds, convertPoint)) {
                    return secondLayerView;
                }
            }
        }
    }
    return nil;
}

- (BOOL)canAnswerEvent:(UIView *)view {
    
    if (view.hidden || view.alpha <= 0.01 || !view.isUserInteractionEnabled) {
        return NO;
    }
    return YES;
}

@end
