//
//  JQWeChatModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQWeChatModel.h"

@implementation JQWeChatModel

+ (NSArray *)loadWeChatData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wechat" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *sectionList = [NSMutableArray array];
    for (NSArray *rowList in dataList) {
        NSMutableArray *rows = [NSMutableArray array];
        for (NSDictionary *dict in rowList) {
            JQWeChatModel *wechat = [[JQWeChatModel alloc] init];
            [wechat setValuesForKeysWithDictionary:dict];
            [rows addObject:wechat];
        }
        [sectionList addObject:rows];
    }
    return sectionList;
}

@end
