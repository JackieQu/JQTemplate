//
//  JQSqliteHelper.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQSqliteHelper : NSObject

// 增、删、改
+ (BOOL)sqlite3WithSql:(NSString *)sql;

// 查
+ (NSArray *)sqlite3SelectWithSql:(NSString *)sql;

@end

NS_ASSUME_NONNULL_END
