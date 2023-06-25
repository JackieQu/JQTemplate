//
//  NSString+TimeFormat.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/25.
//

#import "NSString+TimeFormat.h"

@implementation NSString (TimeFormat)

- (NSString *)stringFromTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:self];
    return [self stringFromDate:date];
}

- (NSString *)stringFromDate:(NSDate *)date {
    
    NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
    if (timeInterval < 0) {
        return @"未知时间";
    }
    
    if (timeInterval <= 60) {
        return @"刚刚";
    } else if (timeInterval <= 60 * 60) {
        return [NSString stringWithFormat:@"%i分钟前",(int)timeInterval / 60];
    } else if (timeInterval <= 60 * 60 * 24) {
        return [NSString stringWithFormat:@"%i小时前",(int)timeInterval / 60 / 60];
    } else if (timeInterval <= 60 * 60 * 24 * 30) {
        return [NSString stringWithFormat:@"%i天前",(int)timeInterval / 60 / 60 / 24];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        return [formatter stringFromDate:date];
    }
}

@end
