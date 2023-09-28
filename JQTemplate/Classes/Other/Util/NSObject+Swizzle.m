//
//  NSObject+Swizzle.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/8.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

void SwizzleMethod(Class cls, SEL originalSel, SEL swizzledSel) {
    
    if (!cls || !originalSel || !swizzledSel) {
        return;
    }
    
    if (sel_isEqual(originalSel, swizzledSel)) {
        return;
    }
    
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSel);
    if (!originalMethod || !swizzledMethod) {
        return;
    }
    
    BOOL flag = class_addMethod(cls,
                                originalSel,
                                method_getImplementation(swizzledMethod),
                                method_getTypeEncoding(swizzledMethod));
    if (flag) {
        class_replaceMethod(cls,
                            swizzledSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSObject (Swizzle)

@end
