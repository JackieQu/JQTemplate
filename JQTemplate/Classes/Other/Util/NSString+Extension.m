//
//  NSString+Extension.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//

#import "NSString+Extension.h"
#import <objc/runtime.h>

@implementation NSString (Extension)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSString replaceInstanceSelector:@selector(sizeWithFont:) withSelector:@selector(my_sizeWithAttributes:)];
    });
}

+ (void)replaceInstanceSelector:(SEL)originalSelector withSelector:(SEL)modifiedSelector {
    
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method modifiedMethod = class_getInstanceMethod(cls, modifiedSelector);
    
    BOOL isSuccessful = class_addMethod(cls,
                                        originalSelector,
                                        method_getImplementation(modifiedMethod),
                                        method_getTypeEncoding(modifiedMethod));
    
    if (isSuccessful) {
        class_replaceMethod(cls,
                            modifiedSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        JQLog(@"1");
    } else {
        method_exchangeImplementations(originalMethod, modifiedMethod);
        JQLog(@"2");
    }
}

- (CGSize)my_sizeWithAttributes:(UIFont *)font {
    
    JQLog(@"%s %@",__FUNCTION__,[self class]);
    
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

+ (NSString *)cachePathWith:(NSString *)filename {
    
    return [[NSSearchPathForDirectoriesInDomains(13, 1, 1) lastObject] stringByAppendingPathComponent:filename];
}

@end
