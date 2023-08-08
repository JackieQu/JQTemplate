//
//  JQDemoViewControllerD29_3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/8.
//

#import "JQDemoViewControllerD29_3.h"
#import "JQShopModel.h"
#import "JQShopCell.h"

static NSString *baseUrl = @"http://127.0.0.1/images/";

static NSString *identifier = @"cellID";

@interface JQDemoViewControllerD29_3 () <NSCacheDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) NSOperationQueue *queue;

// 网络请求缓冲池
@property (nonatomic, strong) NSCache *operationCache;

// 图片缓冲池
@property (nonatomic, strong) NSCache *imageCache;

@end

@implementation JQDemoViewControllerD29_3

- (NSCache *)imageCache {
    
    if (!_imageCache) {
        _imageCache = [[NSCache alloc] init];
        _imageCache.countLimit = 5;
    }
    return _imageCache;
}

- (NSCache *)operationCache {
    
    if (!_operationCache) {
        _operationCache = [[NSCache alloc] init];
    }
    return _operationCache;
}

- (NSOperationQueue *)queue {
    
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

-(UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.height -= STATUS_NAV_HEIGHT;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[JQShopCell class] forCellReuseIdentifier:identifier];
        _tableView.rowHeight = 80;
    }
    return _tableView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = [JQShopModel loadShopData];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 系统用于缓存的类
    NSCache *cache = [[NSCache alloc] init];
    // 设置缓存大小 totalCostLimit
    // 设置缓存数量，先缓存的会先被清除
    cache.countLimit = 5;
    cache.delegate = self;
    for (NSInteger i = 0; i < 20; i ++) {
        [cache setObject:[NSString stringWithFormat:@"cache - %@",@(i)] forKey:@(i)];
    }
    for (NSInteger i = 0; i < 20; i ++) {
        NSLog(@"%@",[cache objectForKey:@(i)]);
    }
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self.imageCache removeAllObjects];
    [self.operationCache removeAllObjects];
    
    [self.queue cancelAllOperations];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

/*
 问题 1: tableView 滑动卡顿，图片延时加载
 方案 1: 添加异步请求，在子线程中请求网络，在主线程刷新 UI
 
 问题 2: 反复请求网络图片，增加用户流量消耗
 方案 2: 创建 downloadImage，其属于数据源，当 tableView 滚动时就可以给 cell 的数据赋值，应用了 MVC 模式
 
 问题 3: 当没有请求到图片时，留白影响用户体验（图片还会延时刷新）
 方案 3: 添加默认图片
 
 问题 4: 当该 cell 的网络请求未执行完，又滚动到该 cell，会重复发起网络请求
 方案 4: 创建网络请求缓冲池
 
 问题 5: 当出现数量较多的图片时，内存使用过多，耦合性大
 方案 5: 创建图片缓冲池
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    JQShopModel *shop = self.dataList[indexPath.row];
    cell.shop = shop;
    
    // 为了避免重复加载的问题，创建了一个 downloadImage，属于数据源，当 tableView 滚动时给 cell 的数据赋值
    if ([self.imageCache objectForKey:shop.shop_image]) {
        // 如下载过，直接从内存中获取图片
        cell.iconView.image = [self.imageCache objectForKey:shop.shop_image];
    } else {
        // 从本地缓存获取图片
        UIImage *image = [UIImage imageWithContentsOfFile:[self pathInCache:shop.shop_image]];
        if (image) {
            dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
            dispatch_async(queue, ^{
//                如本地存在，将图片放入内存中
                [self.imageCache setObject:image forKey:shop.shop_image];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    cell.iconView.image = image;
                });
            });
        } else {
            // 如不存在，先设置默认图片，再下载
            cell.iconView.image = [UIImage imageNamed:@"defaultImage"];
            [self downloadImage:indexPath];
        }
    }

    return cell;
}

- (void)downloadImage:(NSIndexPath *)indexPath {
    
    JQShopModel *shop = self.dataList[indexPath.row];
    if ([self.operationCache objectForKey:shop.shop_image]) {
        
        JQLog(@"已经请求过，请等待下载...");
        
    } else {
        
        // 启异步线程
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            
            // 模拟网络延时
            [NSThread sleepForTimeInterval:2];
            // 通过 url 获取网络数据
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,shop.shop_image]]];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://s.cn.bing.net/th?id=OHR.GothicRuins_ZH-CN8317467997_UHD.jpg"]];
            // 将数据转为图片
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                // 将当前操作从操作缓存池中删除
                [self.operationCache removeObjectForKey:shop.shop_image];
                // 将 image 作为 value，url 作为 key
                [self.imageCache setObject:image forKey:shop.shop_image];
                // 将 image 存入沙盒
                [data writeToFile:[self pathInCache:shop.shop_image] atomically:YES];
                // 获取主队列，更新 UI
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // 刷新当前单元格
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }
        }];
        
        // 将请求加入操作缓冲池中
        [self.operationCache setObject:op forKey:shop.shop_image];
        
        // 将请求加入全局队列
        [self.queue addOperation:op];
    }
}

- (NSString *)pathInCache:(NSString *)url {
    
    // 获取沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 获取 url 的最后一项路径和 path 拼接
    path = [path stringByAppendingPathComponent:[url lastPathComponent]];
    NSLog(@"%@",path);
    return path;
}

/*
 将要被清除的对象，如需要存储该对象，可以在此操作（存入数据库等）
 会在缓存对象将要被清理的时候调用，如：
 1. 手动删除对象 - (void)removeObjectForKey:(id)key;
 2. 缓存超出了 NSCache 的属性限制（countLimit 和 totalCostLimit）
 3. 进入后台
 4. 收到内存警告
 */
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    
    NSLog(@"willEvictObject - %@",obj);
}

@end
