//
//  JQCollectionView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/10.
//

#import "JQCollectionView.h"
#import "JQCollectionLayout.h"
#import "JQImageCell.h"

static NSString *identifier = @"JQImageCell";

@interface JQCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageList;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JQCollectionView

+ (instancetype)collectionViewWithFrame:(CGRect)frame superView:(UIView *)superView imageList:(NSArray *)imageList timeInterval:(NSTimeInterval)timeInterval {
    
    JQCollectionLayout *layout = [[JQCollectionLayout alloc] init];
    layout.itemSize = frame.size;
    
    JQCollectionView *collectionView = [[JQCollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.imageList = imageList;
    collectionView.timeInterval = timeInterval;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.numberOfPages = imageList.count;
    pageControl.enabled = NO;
    CGSize pageSize = [pageControl sizeForNumberOfPages:imageList.count];
    pageControl.frame = CGRectMake(collectionView.center.x - pageSize.width / 2, CGRectGetHeight(collectionView.frame) - pageSize.height, pageSize.width, pageSize.height);
    
    collectionView.pageControl = pageControl;
    
    [superView addSubview:collectionView];
    [superView addSubview:pageControl];
    
    [collectionView startTimer];
    
    return collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.pagingEnabled = YES;
        
        [self registerClass:[JQImageCell class] forCellWithReuseIdentifier:identifier];
        
        // 设置当前 index 为 1000
        self.index = 1000;
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
        // 跳转到当前索引
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // 设置一个较大值，使得 collectionView 近似无限循环滚动
    return 100000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JQImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.imageName = self.imageList[indexPath.row % self.imageList.count];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger x = scrollView.contentOffset.x / self.bounds.size.width;
    
    self.index = x;
    
    self.pageControl.currentPage = self.index % self.imageList.count;

    [self startTimer];
}

- (void)startTimer {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(scrollToNextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}

- (void)stopTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollToNextImage {
    
    self.index ++;
    
    self.pageControl.currentPage = self.index % self.imageList.count;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
    
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
@end
