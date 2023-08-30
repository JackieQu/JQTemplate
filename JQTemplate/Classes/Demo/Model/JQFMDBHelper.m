//
//  JQFMDBHelper.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//

#import "JQFMDBHelper.h"
#import "NSString+Extension.h"
#import <FMDB/FMDB.h>

static FMDatabase *_database;

@implementation JQFMDBHelper

+ (NSArray *)executeQuery:(NSString *)sql {
    
    // 0. 初始化数组
    NSMutableArray *dataList = [NSMutableArray array];
    
    // 1. 打开数据库
    if ([_database open]) {
        
        // 2. 准备查询数据
        FMResultSet *resultSet = [_database executeQuery:sql];
        
        // 3. 查询对应数据
        while ([resultSet next]) {
            
            // 4. 获取数据
            // 4.1 根据字段名称获取数据
            NSString *name = [resultSet stringForColumn:@"name"];
            NSUInteger age = [resultSet intForColumn:@"age"];
            
            NSLog(@"name: %@, age: %@", name, @(age));
            
            // 4.2 添加数据到数组中
            [dataList addObject:@{@"name": name, @"age": @(age)}];
        }
        
        // 5. 关闭数据库
        [_database close];
    }
    
    return dataList;
}

+ (BOOL)executeUpdate:(NSString *)sql {
    
    NSLog(@"sql: %@", sql);
    
    // 1. 打开数据库
    if ([_database open]) {
        
        // 2. 增、删、改操作
        BOOL flag = [_database executeUpdate:sql];
        
        // 3. 关闭数据库
        [_database close];
        
        return flag;
    }
    
    return NO;
}

+ (void)initialize {
    
    // 1. 创建数据库
    NSString *filename = [NSString cachePathWith:@"data.sqlite"];
    
    _database = [FMDatabase databaseWithPath:filename];
    
    // 2. 打开数据库
    if ([_database open]) {
        
        NSLog(@"打开数据库成功");
        
        // 3. 创建表
        BOOL flag = [_database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text, age integer);"];
        
        if (flag) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }
        
        // 4. 关闭数据库
        [_database close];
        
    } else {
        NSLog(@"打开数据库失败");
    }
}

@end
