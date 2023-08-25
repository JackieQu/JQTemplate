//
//  JQLeftMenuModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/25.
//

#import "JQLeftMenuModel.h"

@implementation JQLeftMenuModel

+ (NSArray *)loadLeftMenuData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"leftMenu" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dataList) {
        
        JQLeftMenuModel *menu = [[JQLeftMenuModel alloc] init];
        [menu setValuesForKeysWithDictionary:dict];
        [array addObject:menu];
    }
    return array;
}

@end
