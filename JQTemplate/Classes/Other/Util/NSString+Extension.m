//
//  NSString+Extension.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleMethod([self class], @selector(sizeWithFont:), @selector(my_sizeWithAttributes:));
    });
}

- (CGSize)my_sizeWithAttributes:(UIFont *)font {
    
    JQLog(@"%s %@",__FUNCTION__,[self class]);
    
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

+ (NSString *)cachePathWith:(NSString *)filename {
    
    return [[NSSearchPathForDirectoriesInDomains(13, 1, 1) lastObject] stringByAppendingPathComponent:filename];
}

@end
