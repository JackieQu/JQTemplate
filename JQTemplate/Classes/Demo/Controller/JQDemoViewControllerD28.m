//
//  JQDemoViewControllerD28.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/4.
//

#import "JQDemoViewControllerD28.h"

@interface JQDemoViewControllerD28 ()

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JQDemoViewControllerD28

- (NSOperationQueue *)queue {
    
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 200, 150)];
        _imageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self opTest1];
//    [self opTest2];
//    [self opTest3];
//    [self opTest4];
//    [self opTest5];

    [self opMain];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 40);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 200, 100, 40);
    btn2.backgroundColor = [UIColor blueColor];
    [btn2 setTitle:@"暂停" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(suspendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(100, 300, 100, 40);
    btn3.backgroundColor = [UIColor blueColor];
    [btn3 setTitle:@"取消" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    [self.view addSubview:self.imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    __block UIImage *image1;
    
    // 创建操作 1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:@"https://cn.bing.com/az/hprichbg/rb/AutumnNeuschwanstein_EN-CN10604288553_1920x1080.jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        image1 = [UIImage imageWithData:data];
        
        NSLog(@"op1 - %@",[NSThread currentThread]);
    }];
    
    __block UIImage *image2;
    
    // 创建操作 2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:@"https://cn.bing.com/az/hprichbg/rb/OyamaLeaves_EN-CN9925532450_1920x1080.jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        image2 = [UIImage imageWithData:data];
        
        NSLog(@"op2 - %@",[NSThread currentThread]);
    }];
    
    // 创建操作 3，用于合并图片
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
       
        // 创建位图上下文
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(240, 360), NO, 1);
        
        // 设置显示的位置
        [image1 drawInRect:CGRectMake(0, 0, 240, 180)];
        [image2 drawInRect:CGRectMake(0, 180, 240, 180)];
        
        // 获取当前图片上下文
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        NSLog(@"op3 - %@",[NSThread currentThread]);
        
        // 返回主线程，更新 UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.imageView.image = image;
            
            NSLog(@"%@",[NSThread currentThread]);
        }];
    }];
    
    // 设置操作的依赖关系
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    
    // 添加操作到全局队列
    [self.queue addOperations:@[op1,op2,op3] waitUntilFinished:YES];
}

- (void)opMain {
    
    [self.queue addOperationWithBlock:^{
       
        JQLog(@"%@", [NSThread currentThread]);
        JQLog(@"下载图片");
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                  
            JQLog(@"%@", [NSThread currentThread]);
            JQLog(@"更新UI");
        }];
    }];
}

- (void)startAction:(id)sender {
    
    // 最大并发数，比较常用
    self.queue.maxConcurrentOperationCount = 2;
    
    for (NSInteger i = 0; i < 10; i ++) {
        
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@(i)];
        
        [self.queue addOperation:op];
    }
}

- (void)suspendAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSString *curTitle = button.titleLabel.text;
    NSString *title = [curTitle isEqualToString:@"暂停"] ? @"继续" : @"暂停";
    [button setTitle:title forState:UIControlStateNormal];
    
    // 将队列挂起不会导致正在执行的 operation 在任务中途暂停，只是简单的阻止调度新 operation 的执行
    if (self.queue.maxConcurrentOperationCount == 0) {
        return;
    }
    
    // 挂起
    self.queue.suspended = !self.queue.suspended;
    
    JQLog(@"----- %@ -----",curTitle);
}

- (void)cancelAction:(id)sender {
    
    // 取消 queue 中的所有操作
    [self.queue cancelAllOperations];
    
    // 取消挂起状态
    self.queue.suspended = NO;
    
    NSLog(@"----- 取消 -----");
}

// 设置依赖关系
- (void)opTest5 {
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:nil];
    // 设置优先级，数据量少看不出
    op1.queuePriority = -5;
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"解压文件");
    }];
    op2.queuePriority = 0;
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"查看图片");
    }];
    op3.queuePriority = 5;
    
    // 添加 NSOperation 的依赖对象
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    
    // 注意：不能创建环形依赖，如 A 依赖 B，B 依赖 A，这样是错误的
//    [op1 addDependency:op3];
    
    [self.queue addOperations:@[op1,op2,op3] waitUntilFinished:YES];
}

// 设置最大并发数
- (void)opTest4 {
    
    // 最大并发数，NSOperation 比较常用
    self.queue.maxConcurrentOperationCount = 3;
    
    for (NSInteger i = 0; i < 30; i ++) {
        
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@(i)];
        
        [self.queue addOperation:op];
    }
}

// 使用 NSOperationQueue
- (void)opTest3 {
    
    // NSOperationQueue 是基于 GCD 的，它把 GCD 的 block 封装成 operation，NSOperationQueue 是全局队列封装
    // 将 NSOperation 添加到一个 NSOperationQueue（操作队列）中执行，是异步执行的
    
    // 创建一个操作队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"op"];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
       
        NSLog(@"op2 - %@",[NSThread currentThread]);
    }];
    
    // 添加 NSOperation 到 NSOperationQueue 中，通常添加之后，短时间内就会运行
//    [queue addOperation:op];
//    [queue addOperation:op2];
    
    // 添加一个 block 形式的 operation
    [queue addOperationWithBlock:^{

        NSLog(@"op3 - %@",[NSThread currentThread]);
    }];

    [queue addOperations:@[op,op2] waitUntilFinished:YES];
    
    NSLog(@"完成");
}

- (void)opTest2 {
    
    // 并发的执行一个或多个 block 对象，所有相关的 block 都执行完成后，操作才算完成
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"任务一");
    }];
    
    // 通过 addExecutionBlock 方法添加 block 操作，开辟多个线程
    [op addExecutionBlock:^{
        
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"任务二");
    }];
    
    [op addExecutionBlock:^{
        
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"任务三");
    }];
    
    [op start];
}

- (void)opTest1 {
    
    // 基于一个对象和 selector 来创建操作，如果已经有现有的方法来执行需要的任务，就可以使用这个类
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:nil];
    
    // 如果需要在一个 NSOperation 执行完毕后做一些事情，就调用 NSOperation 的 setCompletionBlock 方法来设置要执行的任务
    [op setCompletionBlock:^{
        NSLog(@"完成");
    }];
    
    // 开始执行任务（同步执行）
    // 一个 NSOperation 对象可以通过调用 start 方法来执行任务，默认同步执行
    [op start];
}

- (void)downloadImage:(NSString *)string {
    
    [NSThread sleepForTimeInterval:2];
    
    NSLog(@"%@ - %@", [NSThread currentThread],string);
}

@end
