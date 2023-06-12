//
//  JQDemoViewControllerD14_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import "JQDemoViewControllerD14_2.h"

#define kMinZoomScale 1
#define kMaxZoomScale 2

@interface JQDemoViewControllerD14_2 () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JQDemoViewControllerD14_2

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = self.imageView.frame.size;
        _scrollView.minimumZoomScale = kMinZoomScale;
        _scrollView.maximumZoomScale = kMaxZoomScale;
        _scrollView.bouncesZoom = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _imageView.image = [UIImage imageNamed:@"screen01"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];
}

- (void)doubleTapAction:(UITapGestureRecognizer *)tap {
    
    CGPoint currentPoint = [tap locationInView:tap.view];
    CGRect rect = [self zoomForScale:kMaxZoomScale location:currentPoint];
    [self.scrollView zoomToRect:rect animated:YES];
}

- (CGRect)zoomForScale:(NSInteger)scale location:(CGPoint)location {
    
    CGFloat width = self.imageView.frame.size.width / scale;
    CGFloat height = self.imageView.frame.size.height / scale;
    
    CGFloat x = location.x - width / 2;
    CGFloat y = location.y - height / 2;
    
    return CGRectMake(x, y, width, height);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
    JQLog(@"开始缩放");
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    JQLog(@"停止缩放");
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat scrollBoundsWidth = scrollView.bounds.size.width;
    CGFloat scrollBoundsHeight = scrollView.bounds.size.height;
    
    CGFloat scrollContentWidth = scrollView.contentSize.width;
    CGFloat scrollContentHeight = scrollView.contentSize.height;
    
    CGPoint imageCenter = CGPointMake(scrollContentWidth / 2, scrollContentHeight / 2);
    
    if (scrollContentWidth < scrollBoundsWidth) {
        imageCenter.x = scrollBoundsWidth / 2;
    }
    if (scrollContentHeight < scrollBoundsHeight) {
        imageCenter.y = scrollBoundsHeight / 2;
    }
    self.imageView.center = imageCenter;
}


@end
