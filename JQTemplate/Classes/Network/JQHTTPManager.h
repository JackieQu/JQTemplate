//
//  JQHTTPManager.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/18.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JQHTTPRequestMethod) {
    JQHTTPRequestGet,
    JQHTTPRequestPost,
    JQHTTPRequestPut,
    JQHTTPRequestPatch,
    JQHTTPRequestDelete,
};

typedef void(^JQRequestPrepareBlock)(void);
typedef void(^JQRequestSuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void(^JQRequestFailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface JQHTTPManager : NSObject

+ (JQHTTPManager *)shared;

- (void)requestWithPath:(NSString *)url
                 method:(JQHTTPRequestMethod)method
             parameters:(NSDictionary *)parameters
                prepare:(JQRequestPrepareBlock)prepare
                success:(JQRequestSuccessBlock)success
                failure:(JQRequestFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
