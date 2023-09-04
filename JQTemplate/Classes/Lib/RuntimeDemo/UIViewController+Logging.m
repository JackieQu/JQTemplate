//
//  UIViewController+Logging.m
//  RuntimeDemo
//
//  Created by Sam Lau on 7/5/15.
//  Copyright © 2015 Sam Lau. All rights reserved.
//

#import "UIViewController+Logging.h"
#import <objc/runtime.h>

@implementation UIViewController (Logging)

+ (void)load
{
//    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//        // 获取原始和交换的 sel
//        SEL originalSel = @selector(viewWillAppear:);
//
//        SEL swizzledSel = @selector(my_ViewWillAppear:);
//
//        Method originalMethod = class_getInstanceMethod(self, originalSel);
//
//        Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);
//
//        // method_getImplementation 获取 IMP 指针
//        BOOL success = class_addMethod(self, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//
//        if (success) {
//            // 若添加方法成功，则交换 IMP 指针
//            class_replaceMethod(self, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            // 若添加方法失败，则直接交换 method 的 IMP 指针
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
}

- (void)my_ViewWillAppear:(BOOL)animated {

    [self my_ViewWillAppear:animated];
    
    NSLog(@"%s,%@",__FUNCTION__,[self class]);
}

- (void)swizzled_viewDidAppear:(BOOL)animated
{
    // call original implementation
    [self swizzled_viewDidAppear:animated];
    
    // Logging
    NSLog(@"%@", NSStringFromClass([self class]));
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@end
