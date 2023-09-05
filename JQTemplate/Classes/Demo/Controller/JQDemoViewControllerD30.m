//
//  JQDemoViewControllerD30.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/8.
//

#import "JQDemoViewControllerD30.h"
#import "Reachability.h"
#import "JSONKit.h"

#import <WebKit/WebKit.h>

/*
 target -> Build Phases -> Compile Sources
 若项目为 ARC 模式，则需为非 ARC 模式的文件加入 -fno-objc-arc
 若项目为非 ARC 模式，则需为 ARC 模式的文件加入 -fobjc-arc
 */

@interface JQDemoViewControllerD30 () <NSURLConnectionDataDelegate>

@property (nonatomic, strong) Reachability *reachable;

@property (nonatomic, strong) NSMutableData *data;

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation JQDemoViewControllerD30

- (WKWebView *)webView {
    
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    
//    [self testReachability];
    
    [self testAsyncURLRequest];
//    [self testSyncURLRequest];
//
//    [self testURLConnectionDataDelegate];
    
//    [self getRequest];
//    [self postRequest];
}

- (void)dealloc {
    
    // 移除当前对象的所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 停止监听
    [self.reachable stopNotifier];
}

- (void)testURLConnectionDataDelegate {
    
    self.data = [NSMutableData data];
    
    NSString *urlString = @"https://www.runoob.com/try/demo_source/movie.ogg";
    
    // 若接口中有中文
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connect = [NSURLConnection connectionWithRequest:request delegate:self];
    
    // 开启网络连接
    [connect start];
}

// 接收服务器返回响应信息
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    JQLog(@"%@",response);
}

// 接收数据（多次调用）
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.data appendData:data];
    
    JQLog(@"%@",data);
}

// 请求完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [self.data writeToFile:@"/Users/JackieQu/Desktop/test.ogg" atomically:YES];
    
    JQLog(@"网络请求完成");
}

- (void)testSyncURLRequest {
    
    NSURL *url = [NSURL URLWithString:@"http://t.weather.sojson.com/api/weather/city/101030100"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 同步网络请求
    NSURLResponse *response = nil;
    
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    JQLog(@"%@",response);
    
    JQLog(@"%@",error);
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    JQLog(@"%@",string);
}

- (void)testAsyncURLRequest {
    
    // 1. 创建 URL（访问网络资源的唯一地址）
    NSURL *url = [NSURL URLWithString:@"http://t.weather.sojson.com/api/weather/city/101030100"];
    
    // 2. 创建网络请求
    /*
     cachePolicy 缓存策略
     
     NSURLRequestUseProtocolCachePolicy = 0,        //自动缓存策略
     NSURLRequestReloadIgnoringLocalCacheData = 1,  //每次都请求网络，无论本地是否存在缓存
     NSURLRequestReturnCacheDataElseLoad = 2,       //如果有缓存返回缓存，没有就加载网络
     NSURLRequestReturnCacheDataDontLoad = 3,       //如果有缓存返回缓存，没有也不加载网络
     
     timeoutInterval 请求超时时间，默认 60，一般设置 10 ～ 20s
     */
    
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
    
    // 3. 建立连接
    /*
     sendAsynchronousRequest 异步网络连接
     queue 可以传主队列，或全局队列
     
     [NSOperationQueue mainQueue]       无需调到主队列直接更新
     [[NSOperationQueue alloc] init]    需要调回主线程更新 UI
     */
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        // response         服务器响应信息，一般下载时用
        // data             服务器返回数据
        // connectionError  网络请求错误
        
        // 服务器与客户端以二进制流通讯
        
        JQLog(@"%@",data);
        
        JQLog(@"%@",[NSThread currentThread]);
        
        if (connectionError) {
            
            JQLog(@"错误信息 - %@",connectionError);
            
        } else {
            
            JQLog(@"响应信息 - %@",response);
            
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            JQLog(@"%@",string);
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
            JQLog(@"%@",json);
            
            // JSONKit
            NSDictionary *json2 = [data objectFromJSONData];
            JQLog(@"%@",json2);
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                // 更新 UI
                [self.webView loadHTMLString:string baseURL:url];
            }];
        }
    }];
}

- (void)testReachability {
    
    // 根据主机名判断网络是否连接
    self.reachable = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    // 注册网络监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged) name:kReachabilityChangedNotification object:nil];
    
    // 开启监听
    [self.reachable startNotifier];
}

- (void)reachabilityChanged {
    
    switch (self.reachable.currentReachabilityStatus) {
        case NotReachable:
            JQLog(@"暂无网络连接");
            break;
        case ReachableViaWiFi:
            JQLog(@"WiFi网络");
            break;
        case ReachableViaWWAN:
            JQLog(@"移动蜂窝网络");
            break;
        default:
            JQLog(@"未知网络连接");
            break;
    }
}

- (void)postRequest {
    
    NSString *username = @"JackieQu";
    NSString *password = @"123456";
    
    // 获取接口
    NSString *urlString = @"http://127.0.0.1/login.php";
    
    // 中文转码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 可变请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10];
    // 设置请求方式
    request.HTTPMethod = @"POST";
    
    NSString *bodyString = [NSString stringWithFormat:@"username=%@&password=%@",username,password];
    
    // 设置请求体
    request.HTTPBody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        JQLog(@"%@",string);
    }];
}

- (void)getRequest {
    
    NSString *username = @"JackieQu";
    NSString *password = @"123456";
    
    // 获取接口
    NSString *urlString = @"http://127.0.0.1/login.php";
    
    // 拼接参数
    urlString = [NSString stringWithFormat:@"%@?username=%@&password=%@",urlString,username,password];
    
    // 中文转码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        JQLog(@"%@",string);
    }];
}

@end
