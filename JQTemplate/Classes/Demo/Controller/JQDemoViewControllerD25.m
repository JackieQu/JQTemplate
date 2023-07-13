//
//  JQDemoViewControllerD25.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/13.
//

#import "JQDemoViewControllerD25.h"

#define angleToRadian(angle) angle * M_PI / 180

@interface JQDemoViewControllerD25 ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) CALayer *layer;

@property (nonatomic, strong) UIView *referenceView;

@end

@implementation JQDemoViewControllerD25

- (UIView *)referenceView {
    
    if (!_referenceView) {
        _referenceView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _referenceView.backgroundColor = [UIColor orangeColor];
    }
    return _referenceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.referenceView];
    
    [self test];
    [self addImageToLayer];
    
    // UIView 与 CALayer：当视图需要响应时使用 UIView，仅作为展示时使用 CALayer
    // 隐式动画只存着于 CALayer 的子层上
    CALayer *layer = [CALayer layer];
    
    layer.frame = CGRectMake(100, 100, 100, 100);
    
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    
    self.layer = layer;
    
    [self.view.layer addSublayer:layer];
}

- (void)test {
    
    // 每个 UIView 都存在一个 CALayer
    // CALayer 属于 QuartzCore 绘图框架，负责描边、圆角、阴影等功能
    // UIColor 与 CGColor：CGColor 属于 QuartzCore，可以应用于 Mac 上
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.image = [UIImage imageNamed:@"screen01"];
    
    imageView.layer.borderWidth = 2;
    
    imageView.layer.borderColor = [UIColor yellowColor].CGColor;
    
    //    imageView.layer.cornerRadius = 50;
    //
    //    imageView.layer.masksToBounds = YES;
    
    // z = 1 绕着 z 轴旋转 45 度
    //    imageView.layer.transform = CATransform3DMakeRotation(angleToRadian(45), 0, 0, 1);
    
    // achorPoint 锚点：范围 0 ～ 1，默认（0.5，0.5）
    // position 位置：以父视图为参考系，默认 center
    imageView.layer.anchorPoint = CGPointMake(0, 0);
    
    imageView.layer.position = CGPointMake(100, 100);
    
    self.imageView = imageView;
    
    [self.view addSubview:imageView];
    
    NSLog(@"contents: %@",imageView.layer.contents);
    NSLog(@"%@",NSStringFromCGRect(imageView.frame));
}

- (void)testAnimation {
    
    [UIView animateWithDuration:2 animations:^{
        
        self.imageView.layer.transform = CATransform3DMakeRotation(angleToRadian(45), 0, 0, 1);
    }];
}

- (void)addImageToLayer {
    
    // 添加图片至 CALayer
    CALayer *layer = [CALayer layer];
    
    layer.frame = CGRectMake(100, 100, 100, 100);
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    layer.contents = (id)[UIImage imageNamed:@"screen01"].CGImage;
    
    [self.view.layer addSublayer:layer];
    
    NSLog(@"contents: %@",layer.contents);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self testAnimation];
    
    self.layer.transform = CATransform3DMakeTranslation(arc4random_uniform(100), arc4random_uniform(100), arc4random_uniform(100));
}

@end
