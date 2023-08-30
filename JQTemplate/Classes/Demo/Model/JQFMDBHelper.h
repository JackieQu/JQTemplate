//
//  JQFMDBHelper.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQFMDBHelper : NSObject

/** 增、删、改 */
+ (BOOL)executeUpdate:(NSString *)sql;

/** 查 */
+ (NSArray *)executeQuery:(NSString *)sql;

@end

NS_ASSUME_NONNULL_END
