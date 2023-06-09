//
//  JQBaseModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "JQBaseModel.h"

@implementation JQBaseModel

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

@end
