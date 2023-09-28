//
//  NSObject+Swizzle.h
//  JQTemplate
//
//  Created by JackieQu on 2023/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void SwizzleMethod(Class cls, SEL originalSel, SEL swizzledSel);

@interface NSObject (Swizzle)

@end

NS_ASSUME_NONNULL_END
