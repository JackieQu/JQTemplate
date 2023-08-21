//
//  NSURL+Param.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Param)

- (NSDictionary *)parameters;
- (NSString *)valueForParameter:(NSString *)parameterKey;

@end

NS_ASSUME_NONNULL_END
