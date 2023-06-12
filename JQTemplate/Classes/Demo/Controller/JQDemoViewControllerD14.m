//
//  JQDemoViewControllerD14.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import "JQDemoViewControllerD14.h"

@interface JQDemoViewControllerD14 () <UIScrollViewDelegate>

{
    NSInteger _index;
}
@property (nonatomic, strong) UIScrollView *testScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JQDemoViewControllerD14

- (UIScrollView *)testScrollView {
    
    if (!_testScrollView) {
        _testScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 16)];
        _testScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
        _testScrollView.delegate = self;
        _testScrollView.pagingEnabled = YES;
        _testScrollView.showsVerticalScrollIndicator = NO;
        _testScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _testScrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 5;
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:5];
        _pageControl.bounds = (CGRect){CGPointZero, pageControlSize};
        _pageControl.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_WIDTH * 9 / 16 - (pageControlSize.height + 10) / 2);
    }
    return _pageControl;
}

- (NSTimer *)timer {
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFireAction) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentOffset = CGPointMake(200, 0);
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height * 2);
    scrollView.contentInset = UIEdgeInsetsMake(50, 50, 50, 50);
    scrollView.delegate = self;
    scrollView.directionalLockEnabled = YES;
    scrollView.bounces = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.pagingEnabled = YES;
//    scrollView.scrollEnabled = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0);
    scrollView.decelerationRate = 0.5;
    scrollView.scrollsToTop = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width * 2, self.view.bounds.size.height * 2)];
    imageView.image = [UIImage imageNamed:@"screen01"];
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
     */
    
    [self.view addSubview:self.testScrollView];
    for (NSUInteger i = 0; i < 5; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"test_0%ld.jpg", i + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 16);
        imageView.backgroundColor = [UIColor randomColor];
        [self.testScrollView addSubview:imageView];
    }
    [self.view addSubview:self.pageControl];
    [self.timer fire];
}

- (void)timerFireAction {
    
    [self.testScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _index, 0) animated:YES];
    _index ++;
    if (_index == 5) {
        _index = 0;
    };
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    JQLog(@"正在滚动");
    
    NSInteger currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _index = currentIndex;
    self.pageControl.currentPage = _index;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    JQLog(@"开始拖拽");
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    JQLog(@"停止拖拽");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    JQLog(@"开始减速");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    JQLog(@"停止减速");
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFireAction) userInfo:nil repeats:YES];
}

@end
