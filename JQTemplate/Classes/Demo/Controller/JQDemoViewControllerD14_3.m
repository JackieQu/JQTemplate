//
//  JQDemoViewControllerD14_3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import "JQDemoViewControllerD14_3.h"

@interface JQDemoViewControllerD14_3 () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *leftImageView, *centerImageView, *rightImageView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalPage;

@property (nonatomic, assign) CGFloat imageHeight;

@end

@implementation JQDemoViewControllerD14_3

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.imageHeight)];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * 3, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [_scrollView addSubview:self.leftImageView];
        [_scrollView addSubview:self.centerImageView];
        [_scrollView addSubview:self.rightImageView];
    }
    return _scrollView;
}

- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width, self.imageHeight)];
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.imageHeight)];
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.bounds.size.width * 2, 0, self.scrollView.bounds.size.width, self.imageHeight)];
    }
    return _rightImageView;
}

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageHeight = SCREEN_WIDTH * 9 / 16;
    
    [self.view addSubview:self.scrollView];
    
    for (NSInteger i = 0; i < 5; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"test_%02ld.jpg",i + 1];
        [self.dataList addObject:imageName];
    }
    self.totalPage = self.dataList.count;
    self.currentPage = 1;
    [self resetPageAndConfigImage];
}

- (void)resetPageAndConfigImage {
    
    if (self.scrollView.contentOffset.x > self.scrollView.bounds.size.width) {
        _currentPage = (_currentPage + 1) % _totalPage;
        NSLog(@"向左滑");
    }
    
    if (self.scrollView.contentOffset.x < self.scrollView.bounds.size.width) {
        _currentPage = (_currentPage - 1 + _totalPage) % _totalPage;
        NSLog(@"向右滑");
    }
    
    [self cofigImage];
}

- (void)cofigImage {
    
    NSString *leftName = self.dataList[(_currentPage - 1 + _totalPage) % _totalPage];
    _leftImageView.image = [UIImage imageNamed:leftName];
    
    NSString *centerName = self.dataList[_currentPage];
    _centerImageView.image = [UIImage imageNamed:centerName];
    
    NSString *rightName = self.dataList[(_currentPage + 1) % _totalPage];
    _rightImageView.image = [UIImage imageNamed:rightName];
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0) animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self resetPageAndConfigImage];
}

@end
