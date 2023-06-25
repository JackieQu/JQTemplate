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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"weibo" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *weiboList = [NSMutableArray array];
    for (NSDictionary *dict in dataList) {
        JQWeiboModel *weibo = [[JQWeiboModel alloc] init];
        [weibo setValuesForKeysWithDictionary:dict];
        [weiboList addObject:weibo];
    }
    return weiboList;
}

@end
