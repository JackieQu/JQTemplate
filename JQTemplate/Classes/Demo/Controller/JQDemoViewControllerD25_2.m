//
//  JQDemoViewControllerD25_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/14.
//

#import "JQDemoViewControllerD25_2.h"

@interface JQDemoViewControllerD25_2 ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation JQDemoViewControllerD25_2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"snow_bg.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    // CADisplayLink，selector 默认每秒调用 60 次
    // CADisplayLink 与 NSTimer：CADisplayLink 用于绘图，NSTimer 用于计时，重复调用
    
    // 创建 CADisplayLink
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(doAction:)];
    
    // 调用次数
//    self.displayLink.preferredFramesPerSecond = 1;
    
    // 添加 CADisplayLink 至 RunLoop 中
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)doAction:(CADisplayLink *)displayLink {
    
    UIImage *image = [UIImage imageNamed:@"snow.jpg"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    // 设置比例
    CGFloat scale = arc4random_uniform(40) / 100.0;
    
    imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGSize screenSize = self.view.bounds.size;
    CGFloat x = arc4random_uniform(screenSize.width);
    CGFloat y = - imageView.frame.size.height * 0.5;
    
    imageView.center = CGPointMake(x, y);
    
    [self.view addSubview:imageView];
    
    [UIView animateWithDuration:10 animations:^{
        
        CGFloat toX = arc4random_uniform(screenSize.width);
        CGFloat toY = imageView.frame.size.height * 0.5 + screenSize.height;
        
        imageView.center = CGPointMake(toX, toY);
        
        // 设置旋转
        imageView.transform = CGAffineTransformRotate(imageView.transform, arc4random_uniform(2 * M_PI));
        
        imageView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
        [imageView removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (!self.displayLink) {
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(doAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
    } else {
     
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

@end
