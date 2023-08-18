//
//  JQHTTPManager.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/18.
//

#import "JQHTTPManager.h"

@interface JQHTTPManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) BOOL isConnect;

@end

@implementation JQHTTPManager

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.manager = [AFHTTPSessionManager manager];
        
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        
        [self startNetworkMonitoring];
    }
    return self;
}

- (void)startNetworkMonitoring {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.isConnect = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.isConnect = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.isConnect = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.isConnect = YES;
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (JQHTTPManager *)shared {
    
    static JQHTTPManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString *)url
                 method:(JQHTTPRequestMethod)method
             parameters:(NSDictionary *)parameters
                prepare:(JQRequestPrepareBlock)prepare
                success:(JQRequestSuccessBlock)success
                failure:(JQRequestFailureBlock)failure {
    
    NSLog(@"请求网址 - %@",url);
    
    if ([self isConnectionAvailable]) {

        //预处理
        if (prepare) {
            prepare();
        }

        switch (method) {
            case JQHTTPRequestGet:
                [self.manager GET:url parameters:parameters headers:nil progress:nil success:success failure:failure];
                break;
            case JQHTTPRequestPost:
                [self.manager POST:url parameters:parameters headers:nil progress:nil success:success failure:failure];
                break;
            case JQHTTPRequestPut:
                [self.manager PUT:url parameters:parameters headers:nil success:success failure:failure];
                break;
            case JQHTTPRequestDelete:
                [self.manager DELETE:url parameters:parameters headers:nil success:success failure:failure];
                break;
            default:
                break;
        }

    } else {

        [self showAlert];
    }
}

- (BOOL)isConnectionAvailable {
    
    return self.isConnect;
}

- (void)showAlert {
    
    JQLog(@"error");
}

@end
