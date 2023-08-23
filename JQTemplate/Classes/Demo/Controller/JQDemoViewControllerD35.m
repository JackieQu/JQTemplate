//
//  JQDemoViewControllerD35.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/22.
//

#import "JQDemoViewControllerD35.h"

@interface JQDemoViewControllerD35 ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSLayoutConstraint *topMargin;

@property (nonatomic, assign) BOOL isDownward;

@end

@implementation JQDemoViewControllerD35

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = NO;
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haixianzizhu"]];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:imageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sanbaiwei"]];
    imageView2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xielaosong"]];
    imageView3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:imageView3];
    
    self.scrollView.height = self.view.width * 9 / 16;
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0],
    ]];
    
    [self.scrollView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeHeight multiplier:1 constant:0],
        
        [NSLayoutConstraint constraintWithItem:imageView2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeRight multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:imageView2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1 constant:0],
        
        [NSLayoutConstraint constraintWithItem:imageView3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:imageView2 attribute:NSLayoutAttributeRight multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:imageView3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:imageView3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeRight multiplier:1 constant:0],

        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:imageView2 attribute:NSLayoutAttributeWidth multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:imageView2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:imageView3 attribute:NSLayoutAttributeWidth multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:imageView2 attribute:NSLayoutAttributeHeight multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:imageView2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:imageView3 attribute:NSLayoutAttributeHeight multiplier:1 constant:0],
    ]];
    
    self.topMargin = self.view.constraints.firstObject;
    
    self.isDownward = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [UIView animateWithDuration:1 animations:^{
//
//        CGRect rect = self.scrollView.frame;
//        rect.origin.y += 100;
//        self.scrollView.frame = rect;
//    }];
    
    if (self.scrollView.frame.origin.y + self.scrollView.frame.size.height >= self.view.frame.size.height) {
        self.isDownward = NO;
    }
    
    if (self.topMargin.constant <= 0) {
        self.isDownward = YES;
    }
  
    if (self.isDownward) {
        self.topMargin.constant += 100;
    } else {
        self.topMargin.constant -= 100;
    }
    
    [UIView animateWithDuration:1 animations:^{

        // layoutIfNeeded 当子视图约束更改时，由父视图调用，刷新约束
        [self.view layoutIfNeeded];
    }];
}

@end
