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
    
    NSLog(@"%@",[NSThread mainThread]);
    NSLog(@"%@",[NSThread currentThread]);

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
    
    [self performSelectorInBackground:@selector(loadImage) withObject:nil];
}

- (void)loadImage {
    
    NSLog(@"loadImage - %@",[NSThread currentThread]);
    
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
    
    NSLog(@"goToMainThread - %@",[NSThread currentThread]);
    
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
                
                NSLog(@"%@ 余票 %@ 张",[NSThread currentThread],@(self.ticketCount));
                self.ticketCount --;
                
            } else {
                
                NSLog(@"暂无余票");
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
    
    NSLog(@"%@ - %@",[NSThread currentThread], string);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    NSLog(@"%@",[NSThread currentThread]);
//
//    [self performSelectorInBackground:@selector(doAction) withObject:nil];
//}

// 多线程体验
- (void)doAction {
    
    for (NSInteger i = 0; i < 100; i ++) {
        
        // 阻塞状态
//        [NSThread sleepForTimeInterval:2];
//        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
        
        NSLog(@"curThread - %@,%@",[NSThread currentThread],@(i));
        
        // 可以在子线程获取主线程
        NSLog(@"mainThread - %@",[NSThread mainThread]);
        
        if (i == 10) {
            
            // 退出
            [NSThread exit];
        }
    }
}

@end
