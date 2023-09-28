//
//  JQBaseModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "JQBaseModel.h"

@implementation JQBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
        @"ID":      @[@"ID", @"id"],
        @"desc":    @[@"desc", @"description"],
        @"isNew":   @[@"isNew", @"new"],
    };
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:dict];
    }
    return [[self alloc] init];
}

+ (NSDictionary *)dictionaryWithModel:(JQBaseModel *)model {
    
    return [model mj_keyValues];
}

+ (instancetype)modelWithPath:(NSString *)path {
    
    path = [[NSBundle mainBundle] pathForResource:path ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    JQBaseModel *model = [self modelWithDictionary:dict];
    return model;
}
  
+ (NSArray *)modelArrayWithPath:(NSString *)path {
    
    path = [[NSBundle mainBundle] pathForResource:path ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        JQBaseModel *model = [self modelWithDictionary:dict];
        [dataList addObject:model];
    }
    return dataList;
}

@end
