//
//  JQDemoTableModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/9.
//

#import "JQDemoTableModel.h"

@implementation JQDemoTableModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
        @"sections": @"JQDemoSectionModel",
    };
}

+ (instancetype)tableModel {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JQDemoTable" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    JQDemoTableModel *tableModel = [JQDemoTableModel modelWithDictionary:dict];
    return tableModel;
}

@end

@implementation JQDemoSectionModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
        @"rows": @"JQDemoRowModel",
    };
}

@end

@implementation JQDemoRowModel

@end
