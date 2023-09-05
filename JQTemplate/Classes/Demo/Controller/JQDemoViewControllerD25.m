//
//  JQDemoViewControllerD25.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/13.
//

#import "JQDemoViewControllerD25.h"

#define angleToRadian(angle) angle * M_PI / 180

@interface JQDemoViewControllerD25 ()

{
    NSInteger _suffix;
}

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) CALayer *layer;

@property (nonatomic, strong) UIView *referenceView;

@property (nonatomic, strong) UIImageView *caImageView;

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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    imageView.center = self.view.center;
    self.caImageView = imageView;
    [self.view addSubview:self.caImageView];
    
    _suffix = 1;
    self.caImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"CA_%ld.jpg",_suffix]];
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
    
    JQLog(@"contents: %@",imageView.layer.contents);
    JQLog(@"%@",NSStringFromCGRect(imageView.frame));
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
    
    JQLog(@"contents: %@",layer.contents);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self testAnimation];
    
//    self.layer.transform = CATransform3DMakeTranslation(arc4random_uniform(100), arc4random_uniform(100), arc4random_uniform(100));
    
    /*
    // 创建基础动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    // 动画路径
    animation.keyPath = @"position";
    
//    // 设置初始状态
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
//    // 设置终止状态
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    
    // 动画距离
    animation.byValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    // 动画的初始和结束模式，fillMode 和 removedOnCompletion 要配合使用
    animation.fillMode = kCAFillModeForwards;   // @"forwards";
    // 动画完成在 layer 删除
    animation.removedOnCompletion = NO;
    
    // 动画时间
    animation.duration = 1;
    
    // 动画加速度
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0 :0.5 :0.9 :0.1];
    
    // 添加动画
    [self.layer addAnimation:animation forKey:@"basic"];
     */
    
    /*
//    [self animation1];
    [self animation2];
     */
    
    /*
    _suffix = _suffix == 5 ? 1 : _suffix + 1;
    
    self.caImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"CA_%ld.jpg",_suffix]];
    
    // 创建过渡动画
    CATransition *animation = [CATransition animation];
    animation.type = @"suckEffect";
    animation.subtype = @"fromLeft";
    animation.duration = 2;
    [self.caImageView.layer addAnimation:animation forKey:nil];
     */
    
    CABasicAnimation *a1 = [CABasicAnimation animation];
    a1.keyPath = @"transform.scale";
    a1.toValue = @(arc4random_uniform(5));
    a1.duration = 0.5;
    a1.removedOnCompletion = NO;
    a1.fillMode = @"forwards";
//    [self.layer addAnimation:a1 forKey:@"a1"];
    
    CABasicAnimation *a2 = [CABasicAnimation animation];
    a2.keyPath = @"transform.rotation";
    a2.toValue = @(arc4random_uniform(M_PI));
    a2.duration = 0.5;
    a2.beginTime = 0.5;
//    [self.layer addAnimation:a2 forKey:nil];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.removedOnCompletion = NO;
    group.fillMode = @"forwards";
    group.animations = @[a1,a2];
    [self.layer addAnimation:group forKey:nil];
}

- (void)animation1 {
    
    // 创建关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position.x";
    
    // 设置关键帧位置
    animation.values = @[@0, @50, @-50, @50, @0];
    
    // 设置关键帧时间
    animation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1];
    
    // 无需设置起始位置
    animation.additive = YES;
    
    // 设置加速度（keyTimes 失效），kCAAnimationPaced 为保持恒定加速度，
    animation.calculationMode = kCAAnimationPaced;
    
    // 设置时间
    animation.duration = 1;
    
    [self.layer addAnimation:animation forKey:@"keyframe"];
}

- (void)animation2 {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 240, 240)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    animation.path = path.CGPath;
    
    animation.duration = 2;
    
    // 重复次数
    animation.repeatCount = HUGE_VALF;  // MAXFLOAT;
    
    [self.layer addAnimation:animation forKey:@"keyframe"];
}

@end
