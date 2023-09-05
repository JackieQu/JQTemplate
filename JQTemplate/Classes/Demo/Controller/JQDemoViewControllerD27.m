//
//  JQDemoViewControllerD27.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/14.
//

#import "JQDemoViewControllerD27.h"

@interface JQDemoViewControllerD27 ()

@property (nonatomic, strong) UIView *testView;

@property (nonatomic, assign) NSInteger ticketCount;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JQDemoViewControllerD27

- (UIView *)testView {

    return _testView;
}

// nonatomic
//- (void)setTestView:(UIView *)testView {
//
//    _testView = testView;
//}

// atomic
//- (void)setTestView:(UIView *)testView {
//
//    // 自旋锁
//    @synchronized(self) {
//        _testView = testView;
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    /*
//    [self test1];
//    [self test2];
//    [self test3];
    
    JQLog(@"%@",[NSThread mainThread]);
    JQLog(@"%@",[NSThread currentThread]);

    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(doAction) object:nil];
    // 就绪状态
    [thread start];
     */
    
    /*
    self.ticketCount = 20;
    
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    thread1.name = @"thread1";
    [thread1 start];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    thread2.name = @"thread2";
    [thread2 start];
     */
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    self.imageView.center = self.view.center;
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.imageView];
    
    /*
    [self performSelectorInBackground:@selector(loadImage) withObject:nil];
     */
    
//    [self gcdTest1];
//    [self gcdTest2];
//    [self gcdTest3];
//    [self gcdTest4];
//    [self gcdTest5];
//    [self gcdTest6];  // 死锁
    

    /*
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (NSInteger i = 0; i < 10; i ++) {
        
        // 并发加异步
        dispatch_async(queue, ^{
            JQLog(@"%@ - %@",[NSThread currentThread], @(i));
        });
    }
     */
    
//    [self gcdOtherTest1];
//    [self gcdOtherTest2];
//    [self gcdOtherTest3];
//    [self gcdOtherTest4];
//    [self gcdOtherTest5];
    [self gcdOtherTest6];
}

- (void)loadImage {
    
    JQLog(@"loadImage - %@",[NSThread currentThread]);
    
    NSString *urlString = @"https://jackiequ.github.io/css/images/banner.jpg";
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    UIImage *image = [UIImage imageWithData:data];
    
    // waitUntilDone:
    // YES: 等待 loadImage 方法执行完毕后，再执行当前线程的后续操作
    // NO: 不等待 loadImage 方法执行完毕后，就执行当前线程的后续操作
    
//    [self performSelectorOnMainThread:@selector(goToMainThread:) withObject:image waitUntilDone:YES];
    
//    [self performSelector:@selector(goToMainThread:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];

    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    
    // -[UIImageView setImage:] must be used from main thread only
//    self.imageView.image = image;
}

- (void)goToMainThread:(UIImage *)image {
    
    [NSThread sleepForTimeInterval:1];
    
    JQLog(@"goToMainThread - %@",[NSThread currentThread]);
    
    self.imageView.image = image;
}

- (void)saleTicket {
    
    while (1) {
        /* token 必须所有线程都能访问到，一般用 self
        @synchronized (<#token#>) {
            <#statements#>
        }
         */
        @synchronized (self) {
            [NSThread sleepForTimeInterval:1];
            if (self.ticketCount > 0) {
                
                JQLog(@"%@ 余票 %@ 张",[NSThread currentThread],@(self.ticketCount));
                self.ticketCount --;
                
            } else {
                
                JQLog(@"暂无余票");
                break;
            }
        }
        
    }
}

- (void)test3 {
    
    // 隐式创建多线程
    [self performSelectorInBackground:@selector(doTest:) withObject:@"JackieQu"];
}

- (void)test2 {
    
    // 通过类方法创建线程，不用显示的开始
    [NSThread detachNewThreadSelector:@selector(doTest:) toTarget:self withObject:nil];
}

- (void)test1 {
    
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(doTest:) object:nil];
    // 线程名
    thread1.name = @"thread1";
    // 线程优先级 0 ~ 1
    thread1.threadPriority = 1.0;
    // 开启线程
    [thread1 start];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(doTest:) object:nil];
    thread2.name = @"thread2";
    thread2.threadPriority = 0.1;
    [thread2 start];
}

- (void)doTest:(NSString *)string {
    
    JQLog(@"%@ - %@",[NSThread currentThread], string);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    JQLog(@"%@",[NSThread currentThread]);
//
//    [self performSelectorInBackground:@selector(doAction) withObject:nil];
//}

// 多线程体验
- (void)doAction {
    
    for (NSInteger i = 0; i < 100; i ++) {
        
        // 阻塞状态
//        [NSThread sleepForTimeInterval:2];
//        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
        
        JQLog(@"curThread - %@,%@",[NSThread currentThread],@(i));
        
        // 可以在子线程获取主线程
        JQLog(@"mainThread - %@",[NSThread mainThread]);
        
        if (i == 10) {
            
            // 退出
            [NSThread exit];
        }
    }
}

- (void)gcdTest6 {
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    JQLog(@"1");
    
    // 在主队列中执行同步操作，产生死锁
    // 原因：同步线程等待主线程结束，才会执行任务。主线程等待同步立即执行，才会执行下一个任务
    dispatch_sync(queue, ^{
        JQLog(@"2");
    });
    
    JQLog(@"3");
}

- (void)gcdTest5 {
    
    // 主队列就是一种特殊的串行队列
    // 特点：专门负责在主线程上调度任务，不会在子线程中去调度任务，无论是同步或异步中调用任务都只会在主线程上执行
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    JQLog(@"开始");
    
    for (NSInteger i = 0; i < 10; i ++) {
        // 主队列执行异步操作，异步操作有一个等待的过程
        dispatch_async(queue, ^{
            JQLog(@"%@ - %@",[NSThread currentThread],@(i));
        });
    }
    
    JQLog(@"结束");
}

// 并行队列：多个线程同时执行
// 异步操作：会开辟新线程
// 执行结果：会开辟新线程，在新开辟的线程中执行任务，任务的完成是无序的，不是立刻执行
- (void)gcdTest4 {
    
    // 开启并行队列
    dispatch_queue_t queue = dispatch_queue_create("JackieQu", DISPATCH_QUEUE_CONCURRENT);
    
    JQLog(@"开始");
    
    for (NSInteger i = 0; i < 10; i ++) {
        
        // 执行异步操作
        dispatch_async(queue, ^{
            
            JQLog(@"%@ - %@",[NSThread currentThread],@(i));
        });
    }
    
    JQLog(@"结束");
}

// 并行队列：多个线程同时执行
// 同步操作：不会开辟新线程
// 执行结果：不会开辟新线程，立即执行
- (void)gcdTest3 {
    
    dispatch_queue_t queue = dispatch_queue_create("JackieQu", DISPATCH_QUEUE_CONCURRENT);

    JQLog(@"开始");
    
    for (NSInteger i = 0; i < 10; i ++) {
        
        dispatch_sync(queue, ^{
            
            JQLog(@"%@ - %@",[NSThread currentThread],@(i));
        });
    }
    
    JQLog(@"结束");
}

// 串行队列：一个一个执行
// 异步操作：会开辟新线程
// 执行结果：开辟一个新线程，在新开辟的线程中执行任务，不是立刻执行
- (void)gcdTest2 {
    
    dispatch_queue_t queue = dispatch_queue_create("JackieQu", NULL);
    
    JQLog(@"开始");
    
    for (NSInteger i = 0; i < 10; i ++) {
        
        // 异步操作
        dispatch_async(queue, ^{
           
            JQLog(@"%@ - %@",[NSThread currentThread],@(i));
        });
    }
    
    JQLog(@"结束");
}

// 串行队列：一个一个执行
// 同步操作：不开辟新线程
// 执行结果：不开辟新线程，一个一个顺序执行
- (void)gcdTest1 {
    
    /*
     label: 队列名
     attr:  队列属性（串行，并发）
     DISPATCH_QUEUE_SERIAL 串行
     DISPATCH_QUEUE_CONCURRRENT 并发
     */
    dispatch_queue_t queue = dispatch_queue_create("JackieQu", DISPATCH_QUEUE_SERIAL);
    
    JQLog(@"开始");
    
    // 同步操作
    // 操作任务：block
    dispatch_sync(queue, ^{
        JQLog(@"%@",[NSThread currentThread]);
    });
    
    JQLog(@"结束");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    JQLog(@"%@",[NSThread currentThread]);
    
    // 获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 执行异步操作
    dispatch_async(queue, ^{
       
        JQLog(@"%@",[NSThread currentThread]);
        
        NSString *urlString = @"https://jackiequ.github.io/css/images/banner.jpg";
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        UIImage *image = [UIImage imageWithData:data];
        
        // 返回主线程更新 UI
        dispatch_sync(dispatch_get_main_queue(), ^{
           
            JQLog(@"%@",[NSThread currentThread]);
            
            self.imageView.image = image;
        });
    });
    
    // 同步操作用途
    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
    
    dispatch_sync(queue2, ^{
        JQLog(@"登录");
    });
    
    dispatch_async(queue2, ^{
        JQLog(@"下载任务 A");
    });
    
    dispatch_async(queue2, ^{
        JQLog(@"下载任务 B");
    });
}

- (void)gcdOtherTest6 {
    
    // 遍历操作
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // iterations 遍历次数
    dispatch_apply(5, queue, ^(size_t i) {
        JQLog(@"%@",@(i));
    });
}

// 中断操作
- (void)gcdOtherTest5 {
    
    // dispatch_barrier_async 一定是自定义队列
    // 这里指定的并行队列应该是自己通过 dispatch_queue_create 函数创建的，如果传的是一个串行队列或者全局并行对了，这个函数等同于 dispatch_async 函数
    dispatch_queue_t queue = dispatch_queue_create("JackieQu", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:3];
        JQLog(@"1");
    });
    
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:2];
        JQLog(@"2");
    });
    
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:1];
        JQLog(@"3");
    });
    
    // 中断操作
    dispatch_barrier_async(queue, ^{
        
        [NSThread sleepForTimeInterval:1];
        JQLog(@"中断操作");
    });
    
    dispatch_async(queue, ^{
       
        [NSThread sleepForTimeInterval:4];
        JQLog(@"4");
    });
    
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:5];
        JQLog(@"5");
    });
}

// 队列调度的第二种方法
- (void)gcdOtherTest4 {
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 进入队列
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
       
        [NSThread sleepForTimeInterval:3];
        JQLog(@"1");
        
        // 离开队列
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:2];
        JQLog(@"2");
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:1];
        JQLog(@"3");
        
        dispatch_group_leave(group);
    });
    
    // 等待调度队列，wait 相当于一个阻塞状态
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    JQLog(@"123");
}

// 队列调度
- (void)gcdOtherTest3 {
    
    // 创建调度组
    dispatch_group_t group = dispatch_group_create();
    // 获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 调度组的异步请求
    dispatch_group_async(group, queue, ^{
       
        [NSThread sleepForTimeInterval:9];
        JQLog(@"下载任务一");
    });
    dispatch_group_async(group, queue, ^{
        
        [NSThread sleepForTimeInterval:5];
        JQLog(@"下载任务二");
    });
    dispatch_group_async(group, queue, ^{
        
        [NSThread sleepForTimeInterval:2];
        JQLog(@"下载任务三");
    });
    dispatch_group_async(group, queue, ^{
        
        [NSThread sleepForTimeInterval:7];
        JQLog(@"下载任务四");
    });
    // 当所有异步请求完成时调用 dispatch_group_notify
    dispatch_group_notify(group, queue, ^{
       
        JQLog(@"全部下载任务完成");
    });
}

- (void)gcdOtherTest2 {
    
    // 延时操作
    JQLog(@"开始");
//    [self performSelector:@selector(doOtherAction) withObject:nil afterDelay:2];
    
    // DISPATCH_TIME_NOW 从现在开始
    // delayInSeconds 延时秒数
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        JQLog(@"%@",[NSThread currentThread]);
    });
}

- (void)doOtherAction {
    
    JQLog(@"doOtherAction - %@",[NSThread currentThread]);
}

- (void)gcdOtherTest1 {
    
    // 单例模式
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        JQLog(@"%@",[NSThread currentThread]);
    });
}

@end
