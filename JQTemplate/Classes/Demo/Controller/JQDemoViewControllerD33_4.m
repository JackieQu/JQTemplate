//
//  JQDemoViewControllerD33_4.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import "JQDemoViewControllerD33_4.h"

@interface JQDemoViewControllerD33_4 () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation JQDemoViewControllerD33_4

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(0, 900);
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.delegate = self;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 900)];
        view.backgroundColor = [UIColor orangeColor];
        [_scrollView addSubview:view];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.scrollView];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    // 下拉刷新
    if (scrollView.contentOffset.y < -100) {
        
        [self loadAnimationWithInsets:UIEdgeInsetsMake(100, 0, 0, 0)];
    }
    
    // 上拉加载
    if (scrollView.bounds.size.height + scrollView.contentOffset.y > scrollView.contentSize.height) {
        
        [self loadAnimationWithInsets:UIEdgeInsetsMake(0, 0, 50, 0)];
    }
}

- (void)loadAnimationWithInsets:(UIEdgeInsets)insets {
    
    JQLog(@"%@",insets.top ? @"发起下拉刷新" : @"发起上拉加载");
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.scrollView.contentInset = insets;
        
    } completion:^(BOOL finished) {
        
        [self resume];
    }];
}

- (void)resume {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
    });
}

@end
