//
//  JQGoodsModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/27.
//

#import "JQGoodsModel.h"

@implementation JQGoodsModel

+ (NSArray *)loadGoodsData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mogujie" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *goodsList = [NSMutableArray array];
    for (NSDictionary *goodsDict in dataList) {
        JQGoodsModel *goods = [[JQGoodsModel alloc] init];
        [goods setValuesForKeysWithDictionary:goodsDict];
        [goodsList addObject:goods];
    }
    return goodsList;
}

@end
