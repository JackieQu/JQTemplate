//
//  JQMessageModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/16.
//

#import "JQMessageModel.h"

@implementation JQMessageModel

+ (NSArray *)loadMessageData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *messageList = [NSMutableArray array];
    for (NSDictionary *dict in dataList) {
        JQMessageModel *message = [[JQMessageModel alloc] init];
        [message setValuesForKeysWithDictionary:dict];
        [messageList addObject:message];
    }
    return messageList;
}

@end
