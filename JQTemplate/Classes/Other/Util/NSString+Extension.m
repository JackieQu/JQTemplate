//
//  NSString+Extension.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)cachePathWith:(NSString *)filename {
    
    return [[NSSearchPathForDirectoriesInDomains(13, 1, 1) lastObject] stringByAppendingPathComponent:filename];
}

@end
