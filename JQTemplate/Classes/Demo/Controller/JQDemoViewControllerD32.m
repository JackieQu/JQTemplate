//
//  JQDemoViewControllerD32.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/11.
//

#import "JQDemoViewControllerD32.h"

@interface JQDemoViewControllerD32 () <NSURLSessionDataDelegate>

@end

@implementation JQDemoViewControllerD32

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     NSURLConnection 在开发中会使用的越来越少，iOS9 已经将 NSURLConnection 废弃，现在最低版本一般适配 iOS9，所以也可以使用
     NSURLConnection 相对于 NSURLSession 安全性较低
     NSURLConnection 下载有峰值，处理较繁琐
     
     尽管适配最低版本 iOS7，也可以使用 NSURLSession（AFN 已经不支持 NSURLConnection）
     
     NSURLSession: 会话，默认为挂起状态，若要请求网络，需要开启
     
     [NSURLSession sharedSession] 获取全局的 NSURLSession 对象（在 iPhone 的所有 app 共用一个全局 session）
     
     NSURLSessionUploadTask -> NSURLSessionDataTask -> NSURLSessionTask
     NSURLSessionDownloadTask -> NSURLSessionTask
     
     NSURLSessionDownloadTask 默认下载到 tmp 文件夹，下载完成后删除临时文件，所以需要在删除文件之前，将其移到 cache 中
     */
    
//    JQLog(@"%@",NSSearchPathForDirectoriesInDomains(9, 1, 1));
    
//    [self getTest];
//    [self postTest];
//    [self downloadTest];
    
    // delegate
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/login.php?username=JackieQu&password=123456"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url];
    
    [task resume];
}

- (void)downloadTest {
    
    NSURL *url = [NSURL URLWithString:[@"http://127.0.0.1/周传雄-有没有一首歌会让你想起我.mp3" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        // location，下载到沙盒的路径
        JQLog(@"下载完成 - %@",location);
        
        // response.suggestedFilename 响应信息中资源的文件名
        NSString *cachesPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        JQLog(@"缓存路径 - %@",cachesPath);
        
        // 获取文件管理器
        NSFileManager *manager = [NSFileManager defaultManager];
        
        // 将临时文件移动到缓存目录下
        // [NSURL fileURLWithPath:cachesPath] 将本地路径转为 URL 类型
        // 若 URL 地址不争气，则生成的 url 对象为空
        [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:cachesPath] error:NULL];
    }];
    
    [task resume];
}

- (void)postTest {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/login.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方式
    request.HTTPMethod = @"POST";
    
    // 设置请求体
    request.HTTPBody = [@"username=JackieQu&password=123456" dataUsingEncoding:NSUTF8StringEncoding];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        JQLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }] resume];
}

- (void)getTest {
    
    // 创建 url
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/login.php?username=JackieQu&password=123456"];
    
    // 创建 session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 创建任务
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        JQLog(@"task - %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    // 开启网络任务
    [task resume];
    
    /*
    // 创建 request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task2 = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        JQLog(@"task2 - %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    [task2 resume];
     */
}

#pragma mark - NSURLSessionDataDelegate Methods

// 接收服务器响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    JQLog(@"%s",__FUNCTION__);
    
    // 允许接受服务器回传数据
    completionHandler(NSURLSessionResponseAllow);
}

// 接受服务器回传数据，可能执行多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    JQLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

// 请求成功或失败
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    JQLog(@"%@",error);
}

@end
