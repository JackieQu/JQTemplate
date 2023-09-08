//
//  UITabBar+HitTest.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/8.
//

#import "UITabBar+HitTest.h"
//#import <objc/runtime.h>
#import "JQCustomTabBar.h"

@implementation UITabBar (HitTest)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSel = @selector(hitTest:withEvent:);
        SEL swizzledSel = @selector(my_hitTest:withEvent:);
        
        Method originalMethod = class_getInstanceMethod(self, originalSel);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);
        
        BOOL flag = class_addMethod(self, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (flag) {
            class_replaceMethod(self, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
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
