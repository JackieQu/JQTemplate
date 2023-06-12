//
//  JQDemoViewControllerD13.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import "JQDemoViewControllerD13.h"
#import "JQDemoView.h"
#import "UIPanGestureRecognizer+Direction.h"
#import "JQAssistiveButton.h"

@interface JQDemoViewControllerD13 () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) JQDemoView *demoView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIPinchGestureRecognizer *pinch;

@end

@implementation JQDemoViewControllerD13

- (JQDemoView *)demoView {
    
    if (!_demoView) {
        _demoView = [[JQDemoView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _demoView.backgroundColor = [UIColor orangeColor];
    }
    return _demoView;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 300, 400)];
        _imageView.image = [UIImage imageNamed:@"screen01"];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.demoView];
    
    [self.view addSubview:self.imageView];
    
    [self addTapGesture];
    [self addLongPressGesture];
    [self addSwipeGesture];
    [self addPanGesture];
    [self addPinchGesture];
    [self addRotationGesture];
    
    JQAssistiveButton *btn = [JQAssistiveButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake) {
        JQLogFunction
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    JQLogFunction
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    JQLogFunction
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  
    if (gestureRecognizer == self.pinch) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

#pragma mark - Tap
- (void)addTapGesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.imageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2:)];
    tap2.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:tap2];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    JQLog(@"%s",__FUNCTION__);
}

- (void)tapAction2:(UITapGestureRecognizer *)tap {
    
    JQLog(@"%s",__FUNCTION__);
}

#pragma mark - LongPress
- (void)addLongPressGesture {
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.imageView addGestureRecognizer:longPress];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        JQLog(@"开始");
    } else if (longPress.state == UIGestureRecognizerStateChanged) {
        JQLog(@"改变");
    } else if (longPress.state == UIGestureRecognizerStateEnded) {
        JQLog(@"结束");
    }
}

#pragma mark - Siwpe
- (void)addSwipeGesture {
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:swipe];
}

- (void)swipeAction:(UISwipeGestureRecognizer *)swipe {
    
    JQLog(@"轻扫");
}

#pragma mark - Pan
- (void)addPanGesture {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.imageView addGestureRecognizer:pan];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    CGPoint point = [pan translationInView:self.view];
    self.imageView.center = CGPointMake(self.imageView.center.x + point.x, self.imageView.center.y + point.y);
    [pan setTranslation:CGPointZero inView:self.imageView];
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        UIPanGestureMoveDirection direction = [pan judgeMoveDirection:point];
        switch (direction) {
            case UIPanGestureMoveUp:
                JQLog(@"向上滑动");
                break;
            case UIPanGestureMoveDown:
                JQLog(@"向下滑动");
                break;
            case UIPanGestureMoveLeft:
                JQLog(@"向左滑动");
                break;
            case UIPanGestureMoveRight:
                JQLog(@"向右滑动");
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - Pinch
- (void)addPinchGesture {
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    pinch.delegate = self;
    self.pinch = pinch;
    [self.imageView addGestureRecognizer:pinch];
}

- (void)pinchAction:(UIPinchGestureRecognizer *)pinch {
    
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

#pragma mark - Rotation
- (void)addRotationGesture {
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    rotation.delegate = self;
    [self.imageView addGestureRecognizer:rotation];
}

- (void)rotationAction:(UIRotationGestureRecognizer *)rotation {
    
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    rotation.rotation = 0;
}

@end
