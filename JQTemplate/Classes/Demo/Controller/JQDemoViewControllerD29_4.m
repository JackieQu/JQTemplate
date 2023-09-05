//
//  JQDemoViewControllerD29_4.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/8.
//

#import "JQDemoViewControllerD29_4.h"
#import "JQShopModel.h"
#import "JQShopCell.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>

static NSString *baseUrl = @"http://127.0.0.1/images/";

static NSString *identifier = @"cellID";

@interface JQDemoViewControllerD29_4 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JQDemoViewControllerD29_4

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.height -= STATUS_NAV_HEIGHT;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 80;
        
        [_tableView registerClass:[JQShopCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = [JQShopModel loadShopData];
    }
    return _dataList;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _imageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    // 获取缓存大小
    CGFloat size = (CGFloat)[[SDImageCache sharedImageCache] totalDiskSize] / 1024 / 1024;
    JQLog(@"%.2f", size);
    
    [self.view addSubview:self.imageView];
    
    // 本地获取 gif
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"lotus" ofType:@"gif"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    [self.imageView sd_setImageWithURL:url];
    
    // 网络获取 gif
    NSString *urlString = @"https://s1.4sai.com/src/img/gif/c1/c1064a16792f4fb3b56a1d37ff1ba019.gif?e=1735488000&token=1srnZGLKZ0Aqlz6dk7yF4SkiYf4eP-YrEOdM1sob:RBblx2z1ann9OlZyUU-rmjmiC7s=";
    NSURL *url = [NSURL URLWithString:urlString];
    [self.imageView sd_setImageWithURL:url];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    JQShopModel *shop = self.dataList[indexPath.row];
    cell.shop = shop;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",baseUrl,shop.shop_image];
    urlString = @"https://s.cn.bing.net/th?id=OHR.GothicRuins_ZH-CN8317467997_UHD.jpg";
    NSURL *url = [NSURL URLWithString:urlString];
    UIImage *placeholderImage = [UIImage imageNamed:@"defaultImage"];
    // 网络图片的 url
//    [cell.iconView sd_setImageWithURL:url];
    // 占位图
//    [cell.iconView sd_setImageWithURL:url placeholderImage:placeholderImage];
    // block
//    [cell.iconView sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//        if (error) {
//            JQLog(@"下载失败");
//        } else {
//            JQLog(@"image - %@",image);
//            JQLog(@"cacheType - %@",@(cacheType));
//        }
//    }];
    
    /*
     options

     SDWebImageRetryFailed = 1 << 0,                //失败后重试 (经常使用)
     SDWebImageLowPriority = 1 << 1,                // UI 交互期间开始下载，导致延迟下载，如UIScrollView减速（经常使用）
     SDWebImageCacheMemoryOnly = 1 << 2,            //只进行内存缓存
     SDWebImageProgressiveDownload = 1 << 3,        //这个标志可以渐进式下载,显示的图像是逐步在下载
     SDWebImageRefreshCached = 1 << 4,              //刷新缓存
     SDWebImageContinueInBackground = 1 << 5,       //后台下载
     SDWebImageHighPriority = 1 << 8,               //优先下载
     SDWebImageDelayPlaceholder = 1 << 9,           //延迟占位符
     SDWebImageTransformAnimatedImage = 1 << 10,    //改变动画形象
     */
//    [cell.iconView sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    // 监测图片下载进度
    [cell.iconView sd_setImageWithURL:url placeholderImage:placeholderImage options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

        // receivedSize 已经收到的大小
        // expectedSize 期待的大小
//        JQLog(@"receivedSize - %@",@(receivedSize));
//        JQLog(@"expectedSize - %@",@(expectedSize));

        CGFloat progress = (float)receivedSize / expectedSize;
        JQLog(@"%.2f%%",progress * 100);

    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        JQLog(@"加载完成");
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 清除缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 获取缓存大小
        CGFloat size = (CGFloat)[[SDImageCache sharedImageCache] totalDiskSize] / 1024 / 1024;
        JQLog(@"%.2f", size);
        JQLog(@"%@",NSHomeDirectory());
    }];
}

@end
