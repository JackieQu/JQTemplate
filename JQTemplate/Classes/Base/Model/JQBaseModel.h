//
//  JQBaseModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQBaseModel : NSObject

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

+ (NSDictionary *)dictionaryWithModel:(JQBaseModel *)model;

+ (instancetype)modelWithPath:(NSString *)path;

+ (NSArray *)modelArrayWithPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
