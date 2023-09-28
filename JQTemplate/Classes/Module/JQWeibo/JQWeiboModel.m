//
//  JQWeiboModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/25.
//

#import "JQWeiboModel.h"
#import "NSString+TimeFormat.h"

@implementation JQWeiboModel

- (NSString *)timer {
    
    return [_timer stringFromTime];
}

+ (NSArray *)loadWeiboData {

    return [JQWeiboModel modelArrayWithPath:@"weibo"];
}

@end
