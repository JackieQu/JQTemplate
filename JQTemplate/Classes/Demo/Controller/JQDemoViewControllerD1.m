//
//  JQDemoViewControllerD1.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQDemoViewControllerD1.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]

@interface JQDemoViewControllerD1 ()

@property (nonatomic, strong) UIView *testView;

@property (nonatomic, strong) NSTimer *testTimer;

@end

@implementation JQDemoViewControllerD1

- (UIView *)testView {
    
    if (!_testView) {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_NAV_HEIGHT, 50, 50)];
        _testView.backgroundColor = [UIColor orangeColor];
    }
    return _testView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.testView];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(testAction) userInfo:nil repeats:YES];
    self.testTimer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    /*
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(testAction2) userInfo:nil repeats:YES];
    self.testTimer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
     */
    
    /*
    UIView *view = [[UIView alloc] init];
    CGRect frame = CGRectMake(100, 100, 100, 100);
    view.frame = frame;
//    view.frame.origin = CGPointMake(100, 100);
    
    view.center = CGPointMake(200, 200);
    
    CGRect frame2 = view.frame;
    frame2.origin = CGPointMake(100, 100);
    view.frame = frame2;
    
    CGRect frame3 = view.frame;
    frame3.origin.x = 0;
    view.frame = frame3;
    
    view.frame = (CGRect){CGPointMake(200, 200), CGSizeMake(200, 200)};

    view.backgroundColor = [UIColor randomColor];
    [self.view addSubview:view];
    
    JQLog(@"%@", NSStringFromCGRect(CGRectZero));
    JQLog(@"%@", NSStringFromCGRect(view.frame));
    JQLog(@"%@", NSStringFromCGRect(view.bounds));
     */
    
    /*
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    view.tag = 1000;
    [self.view addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    view2.backgroundColor = [UIColor blueColor];
    view2.tag = 1001;
    [self.view addSubview:view2];
    
    [self.view bringSubviewToFront:view];
    [self.view sendSubviewToBack:view];
    
    JQLog(@"%@", [view superview]);
    JQLog(@"%@", [self.view subviews]);
    JQLog(@"%@", [self.view viewWithTag:1000]);
     */
    
    /*
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    view.backgroundColor = [UIColor colorWithHue:0.5 saturation:1 brightness:1 alpha:1];
    view.backgroundColor = [UIColor colorWithRed:50 / 255.f green:100 / 255.f blue:150 / 255.f alpha:1];
    view.backgroundColor = RGBA(100, 100, 100, 1);
    view.backgroundColor = [UIColor randomColor];
    view.backgroundColor = [UIColor colorWithHex:0x000000];
    view.backgroundColor = [UIColor colorWithHexString:@"#FF0000"];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"scene"]];
    [self.view addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [[UIImage imageNamed:@"scene"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [self.view addSubview:imageView];
     */
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.testTimer invalidate];
    self.testTimer = nil;
}

- (void)testAction2 {
    
    UIView *view = [[UIView alloc] init];
    view.frame = [UIView randomFrameWithMinValue:50 maxValue:200];
    view.backgroundColor = [UIColor randomRGBAColor];
    [self.view addSubview:view];
}

- (void)testAction {
    
    CGRect frame = self.testView.frame;
        
    static int moveX = 1;
    static int moveY = 1;
    if (frame.origin.x < 0 || frame.origin.x + frame.size.width > SCREEN_WIDTH) {
        moveX *= -1;
    }
    if (frame.origin.y < STATUS_NAV_HEIGHT || frame.origin.y + frame.size.height > SCREEN_HEIGHT) {
        moveY *= -1;
    }
    
    frame.origin.x += moveX;
    frame.origin.y += moveY;
    self.testView.frame = frame;
}

@end
