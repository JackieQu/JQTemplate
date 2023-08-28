//
//  JQDemoViewControllerD39_5.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/28.
//

#import "JQDemoViewControllerD39_5.h"
#import "JQDemoViewControllerD39_6.h"

@interface JQDemoViewControllerD39_5 () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titleNames;

@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation JQDemoViewControllerD39_5

- (NSArray *)titleNames {
    
    if (!_titleNames) {
        _titleNames = @[@"国际",@"国内",@"北京",@"视频",@"娱乐",@"体育"];
    }
    return _titleNames;
}

- (UIScrollView *)titleScrollView {
    
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }
    return _titleScrollView;
}

- (UIScrollView *)contentScrollView {
    
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_NAV_HEIGHT - 40)];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
    }
    return _contentScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    JQLog(@"%f", STATUS_NAV_HEIGHT);
    [self.view addSubview:self.titleScrollView];
    [self.view addSubview:self.contentScrollView];
    
    self.titleScrollView.contentInsetAdjustmentBehavior = NO;
    self.contentScrollView.contentInsetAdjustmentBehavior = NO;

    [self setUpChildControllers];

    [self setUpTitles];
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)setUpChildControllers {
    
    for (NSInteger i = 0; i < self.titleNames.count; i ++) {
        
        JQDemoViewControllerD39_6 *newsVC = [[JQDemoViewControllerD39_6 alloc] init];
        newsVC.title = self.titleNames[i];
        [self addChildViewController:newsVC];
    }
}

- (void)setUpTitles {
    
    CGFloat btnW = 100;
    CGFloat btnH = self.titleScrollView.frame.size.height;
    
    // 用 button 做不是很灵敏，建议用 label 加手势
    for (NSInteger i = 0; i < self.titleNames.count; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.titleNames[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]];
        btn.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        
        [self.titleScrollView addSubview:btn];
    }
    
    self.titleScrollView.contentSize = CGSizeMake(btnW * self.titleNames.count, 0);
    
    self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.titleNames.count, 0);
}

- (void)clickBtn:(UIButton *)button {
    
    NSInteger index = button.tag - 1;
    
    CGPoint point = CGPointMake([UIScreen mainScreen].bounds.size.width * index, 0);
    
    [self.contentScrollView setContentOffset:point animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // contentScrollView 的 width, height
    CGFloat width = scrollView.frame.size.width;
    
    CGFloat height = scrollView.frame.size.height;
    
    // 获取索引
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;
    
    // 处理标题居中
    UIButton *btn = self.titleScrollView.subviews[index];
    
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    
    titleOffset.x = btn.center.x - width / 2;
    
    // 处理左侧边界情况
    if (titleOffset.x < 0) {
        titleOffset.x = 0;
    }
    
    // 处理右侧边界情况
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    
    if (titleOffset.x > maxTitleOffsetX) {
        titleOffset.x = maxTitleOffsetX;
    }
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    JQDemoViewControllerD39_6 *childVC = self.childViewControllers[index];

    // 判断控制器是否加载过
    if ([childVC isViewLoaded]) return;
    
    childVC.view.frame = CGRectMake(offsetX, 0, width, height);
    childVC.view.backgroundColor = [UIColor randomColor];
    
    [scrollView addSubview:childVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

@end
