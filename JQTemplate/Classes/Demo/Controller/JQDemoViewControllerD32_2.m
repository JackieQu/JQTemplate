//
//  JQDemoViewControllerD32_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/11.
//

#import "JQDemoViewControllerD32_2.h"

@interface JQDemoViewControllerD32_2 () <NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) NSURLSessionDownloadTask *task;

@property (nonatomic, strong) NSData *resumeData;

@end

@implementation JQDemoViewControllerD32_2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    [self downloadLargeFile];
}

#pragma mark - 大文件下载

- (void)downloadLargeFile {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    // 测试文件，用视频文件更容易看出效果
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:[@"http://127.0.0.1/周传雄-有没有一首歌会让你想起我.mp3" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    [task resume];
}

#pragma mark - NSURLSessionDownloadDelegate Methods

/**
 监测临时文件下载的数据大小，每次写入临时文件时都会调用

 @param bytesWritten 单次写入数据大小
 @param totalBytesWritten 已经写入数据大小
 @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    // 打印下载进度
    NSLog(@"%.2f%%",totalBytesWritten * 100.0 / totalBytesExpectedToWrite);
}

// 下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:cachesPath] error:NULL];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    NSLog(@"%@",error);
}

#pragma mark - 断点续传

- (void)startAction:(id)sender {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    self.session = session;
    
    self.task = [session downloadTaskWithURL:[NSURL URLWithString:[@"http://127.0.0.1/周传雄-有没有一首歌会让你想起我.mp3" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

    [self.task resume];
}

- (void)suspendAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    NSString *title = btn.titleLabel.text;
    
    [btn setTitle:[title isEqualToString:@"暂停"] ? @"继续" : @"暂停" forState:UIControlStateNormal];
    
    if ([title isEqualToString:@"暂停"]) {
        
        [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            
            // 保存已下载的数据
            self.resumeData = resumeData;
        }];
        
    } else {
        
        // 用 resumeData 创建任务
        self.task = [self.session downloadTaskWithResumeData:self.resumeData];
        
        [self.task resume];
    }
}

@end
