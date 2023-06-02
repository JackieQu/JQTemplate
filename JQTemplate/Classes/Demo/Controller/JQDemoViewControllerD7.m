//
//  JQDemoViewControllerD7.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/2.
//

#import "JQDemoViewControllerD7.h"
#import "JQCustomHUD.h"
#import "JQPopUpView.h"

@interface JQDemoViewControllerD7 ()

@property (nonatomic, strong) JQCustomHUD *hud;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *firstView, *secondView;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) JQPopUpView *popUpView;

@end

@implementation JQDemoViewControllerD7

- (JQCustomHUD *)hud {
    
    if (!_hud) {
        _hud = [[JQCustomHUD alloc] init];
        _hud.title = @"正在加载...";
    }
    return _hud;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.image = [UIImage imageNamed:@"qq"];
    }
    return _imageView;
}

- (UIView *)contentView {
    
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        [_contentView addSubview:self.firstView];
        [_contentView addSubview:self.secondView];
    }
    return _contentView;
}

- (UIImageView *)firstView {
    
    if (!_firstView) {
        _firstView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"screen01.png"]];
        _firstView.frame = CGRectMake(0, 0, 200, 200);
    }
    return _firstView;
}

- (UIImageView *)secondView {
    
    if (!_secondView) {
        _secondView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"screen02"]];
        _secondView.frame = CGRectMake(0, 0, 200, 200);
    }
    return _secondView;
}

- (UIView *)footerView {
    
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
        _footerView.backgroundColor = [UIColor orangeColor];
    }
    return _footerView;
}

- (JQPopUpView *)popUpView {
    
    if (!_popUpView) {
        _popUpView = [[JQPopUpView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    }
    return _popUpView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    [self.hud show];
    
    [self performSelector:@selector(dismissHUD:) withObject:self.hud afterDelay:3];
     */
    
    /*
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    imageView.image = [UIImage imageNamed:@"qq"];
    [self.view addSubview:imageView];
    
    [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        JQLogFunction
        
        [UIView modifyAnimationsWithRepeatCount:3 autoreverses:YES animations:^{
            
            imageView.frame = CGRectMake(200, 400, 100, 100);
//            imageView.backgroundColor = [UIColor orangeColor];
//            imageView.alpha = 0;
            
//            imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
//            imageView.transform = CGAffineTransformScale(imageView.transform, 0.5, 0.5);
            
//            imageView.transform = CGAffineTransformMakeTranslation(100, 100);
//            imageView.transform = CGAffineTransformTranslate(imageView.transform, -50, -50);
            
//            imageView.transform = CGAffineTransformMakeRotation(M_PI);
//            imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI_2);
        }];
    } completion:^(BOOL finished) {
        
        JQLog(@"%@", @(finished));
    }];
     */
    
    /*
    [self.view addSubview:self.imageView];
//    [self animation];
//    [self animation2];
//    [self animation3];
//    [self animation4];
//    [self animation5];
    [self animation6];
     */
    
    /*
    [self.view addSubview:self.contentView];
     */
    
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.popUpView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.popUpView.hidden) {
        [self.popUpView showWithImage:[UIImage imageNamed:@"minion"]];
    } else {
        [self.popUpView dismiss];
    }
    
    __block CGRect rect = self.footerView.frame;
    if (self.footerView.hidden) {
        self.footerView.hidden = NO;
        [UIView animateWithDuration:1 animations:^{
            rect.origin.y -= 49;
            self.footerView.frame = rect;
        }];
    } else {
        [UIView animateWithDuration:1 animations:^{
            rect.origin.y += 49;
            self.footerView.frame = rect;
        } completion:^(BOOL finished) {
            self.footerView.hidden = finished;
        }];
    }
    
//    [UIView transitionWithView:self.contentView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        [self.contentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//    } completion:nil];
    
//    [UIView transitionFromView:self.secondView toView:self.firstView duration:1 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished) {
//
//        [UIView transitionFromView:self.firstView toView:self.secondView duration:1 options:UIViewAnimationOptionTransitionCurlUp completion:nil];
//    }];
    
//    [UIView transitionWithView:self.contentView duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//
//        [self.firstView removeFromSuperview];
//        [self.contentView addSubview:self.secondView];
//
//    } completion:^(BOOL finished) {
//
//        [UIView transitionWithView:self.contentView duration:2 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
//
//            [self.secondView removeFromSuperview];
//            [self.contentView addSubview:self.firstView];
//
//        } completion:nil];
//    }];
}

- (void)animation {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.imageView.alpha = 0;
    }];
}

- (void)animation2 {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.imageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            
            self.imageView.frame = CGRectMake(200, 200, 100, 100);
            self.imageView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1 animations:^{
                
                self.imageView.frame = CGRectMake(100, 200, 100, 100);
            }];
        }];
    }];
}

- (void)animation3 {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI_2);
        
    } completion:^(BOOL finished) {
       
        [UIView animateWithDuration:1 animations:^{

            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, -M_PI_2);
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)animation4 {
    
    [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.imageView.backgroundColor = [UIColor orangeColor];
        
    } completion:^(BOOL finished) {
        
        JQLog(@"%@", @(finished));
    }];
}

- (void)animation5 {
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.imageView.frame = CGRectMake(200, 200, 100, 100);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.imageView.frame = CGRectMake(150, 150, 50, 50);
            
        } completion:^(BOOL finished) {
            
            JQLog(@"%@", @(finished));
        }];
    }];
}

- (void)animation6 {
    
    [UIView animateKeyframesWithDuration:3.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 6.0f animations:^{
            self.imageView.backgroundColor = [UIColor redColor];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:2 / 6.0f animations:^{
            self.imageView.backgroundColor = [UIColor greenColor];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:3 / 6.0f animations:^{
            self.imageView.backgroundColor = [UIColor yellowColor];
        }];
        
    } completion:^(BOOL finished) {
        
        JQLog(@"%@", @(finished));
    }];
}

- (void)dismissHUD:(JQCustomHUD *)sender {
    
    [sender dismiss];
}

@end
