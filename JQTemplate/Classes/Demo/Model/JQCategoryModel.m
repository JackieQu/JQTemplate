//
//  JQCategoryModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/14.
//

#import "JQCategoryModel.h"

@implementation JQCategoryModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSArray *)loadCategoryData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *categoryList = [NSMutableArray array];
    
    for (NSDictionary *dict in dataList) {
        
        JQCategoryModel *category = [[JQCategoryModel alloc] init];
        
        [category setValuesForKeysWithDictionary:dict];
        
        [categoryList addObject:category];
    }
    
    return categoryList;
}

@end
