//
//  JQShopModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/16.
//

#import "JQShopModel.h"

@implementation JQShopModel

+ (NSArray *)loadShopData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meituan" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *shopList = [NSMutableArray array];
    for (NSDictionary *dict in dataList) {
        JQShopModel *shop = [[JQShopModel alloc] init];
        [shop setValuesForKeysWithDictionary:dict];
        [shopList addObject:shop];
    }
    return shopList;
}

@end
