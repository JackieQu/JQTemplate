//
//  JQSqliteHelper.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//

#import "JQSqliteHelper.h"
#import "NSString+Extension.h"
#import "JQStudentModel.h"
#import <sqlite3.h>

static sqlite3 *database = nil;

@interface JQSqliteHelper ()

@end

@implementation JQSqliteHelper

+ (NSArray *)sqlite3SelectWithSql:(NSString *)sql {
    
    // 1、打开数据库
    NSString *filename = [NSString cachePathWith:@"test_sqlite.sqlite"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (sqlite3_open(filename.UTF8String, &database) == SQLITE_OK) {
        
        // 2、执行查询语句
        // a 准备查询操作
//        NSString *sql = @"select * from t_student;";
        
        // b 查询的句柄，游标
        sqlite3_stmt *stmt;
        
        // arg3: 传 -1
        if (sqlite3_prepare(database, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
            
            // c 查询数据
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                // d 获取数据表的内容
                // sqlite3_column_text('句柄', 字段索引值)
                JQStudentModel *student = [[JQStudentModel alloc] init];
                
                NSString *name = [NSString stringWithCString:(const char *)sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding];
                
                NSUInteger age = sqlite3_column_int(stmt, 2);
                
                student.name = name;
                student.age = age;
                
                [array addObject:student];
            }
        }
        
        // 3、关闭数据库
        sqlite3_close(database);
    }
    
    return array;
}

+ (BOOL)sqlite3WithSql:(NSString *)sql {
    
    // 1、打开数据库
    NSString *filename = [NSString cachePathWith:@"test_sqlite.sqlite"];
    
    if (sqlite3_open(filename.UTF8String, &database) == SQLITE_OK) {
        
        // 2、执行 sql 语句
        char *errmsg;
        
        sqlite3_exec(database, sql.UTF8String, NULL, NULL, &errmsg);
        
        // 3、关闭数据库
        sqlite3_close(database);
        
        // 4、返回结果
        return errmsg ? NO : YES;
    }
    
    return NO;
}

+ (void)initialize {
    
    NSString *filename = [NSString cachePathWith:@"test_sqlite.sqlite"];

//    JQLog(@"%@",filename);
    
    // sqlite3 操作
    
    // 1、打开数据库，若不存在则创建
    // arg1: 数据库的沙盒存放地址
    // arg2: 数据库的地址，也叫句柄
    if (sqlite3_open(filename.UTF8String, &database) == SQLITE_OK) {
        
        JQLog(@"数据库打开成功");
        
        // 2、创建表，若表已存在则无需创建
        NSString *sql = @"create table if not exists t_student (id integer primary key autoincrement, name text, age integer);";
        
        // 3、执行 sql 语句
        // arg1: 数据库的句柄
        // arg2: 数据库语句
        char *errmsg;
        
        sqlite3_exec(database, sql.UTF8String, NULL, NULL, &errmsg);
        
        if (errmsg) {
            JQLog(@"创建表失败：%s",errmsg);
        } else {
            JQLog(@"创建表成功");
        }
        
        // 4、关闭数据库
        sqlite3_close(database);
        
    } else {
        JQLog(@"数据库打开失败");
    }
}

@end
