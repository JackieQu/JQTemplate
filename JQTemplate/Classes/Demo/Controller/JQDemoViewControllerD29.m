//
//  JQDemoViewControllerD19.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

/*
 1. sudo apachectl start    开启 apache 服务器
 
 2. sudo apachectl -v       查看 apache 服务器版本
 
 3. sudo vi /etc/apache2/httpd.conf
 
    将 LoadModule php7_module 注释取消保存
 
 4. open /Library/WebServer/Documents
 
    打开资源路径，添加图片，模拟从服务器获取图片资源
 */

#import "JQDemoViewControllerD29.h"
#import "JQShopModel.h"
#import "JQShopCell.h"

static NSString *baseUrl = @"http://127.0.0.1/images/";

static NSString *identifier = @"cellID";

@interface JQDemoViewControllerD29 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) NSOperationQueue *queue;

// 网络请求缓冲池
@property (nonatomic, strong) NSMutableDictionary *operationCache;

// 图片缓冲池
@property (nonatomic, strong) NSMutableDictionary *imageCache;

@end

@implementation JQDemoViewControllerD29

- (NSMutableDictionary *)imageCache {
    
    if (!_imageCache) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}

- (NSMutableDictionary *)operationCache {
    
    if (!_operationCache) {
        _operationCache = [NSMutableDictionary dictionary];
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
    
    [self.view addSubview:self.tableView];
    
    [self setUserDefaults];
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
        cell.iconView.image = self.imageCache[shop.shop_image];
    } else {
        // 如未下载，先设置默认图片，再下载
        cell.iconView.image = [UIImage imageNamed:@"defaultImage"];
        [self downloadImage:indexPath];
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
                // 将 image 作为 value，url 作为 key
                [self.imageCache setObject:image forKey:shop.shop_image];
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

/*
 默认情况下，每个沙盒文件有 3 个文件夹：Documents、Library 和 tmp。因为应用的沙盒机制，应用只能在几个目下读写文件
 
 Documents：苹果建议将程序中建立的或在程序中浏览过的文件数据保存在该目录下，iTunes 备份和恢复时会包括此目录，如果保存了下载的数据，程序提交会被直接拒绝
 Library：存储程序的默认设置或者其他状态信息
 Library/Caches：存放缓存文件，iTunes 不会备份此目录，此目录下的文件不会在应用退出时删除
 Library/Preferences：偏好设置文件
 tmp：提供一个即时创建临时文件的空间，在手机重启时，会丢弃所有 tmp 文件
 */

- (void)setUserDefaults {
    
    // 在模拟器上，沙盒目录是变化的，所以每次都次都要打印
//    NSString *path = NSHomeDirectory();
//    NSLog(@"%@",path);
    
    // 获取沙盒目录的方法
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 追加文件名
    path = [path stringByAppendingPathComponent:@"data.plist"];
    NSArray *array = @[@1,@2,@3,@4,@5];
    [array writeToFile:path atomically:YES];
    NSLog(@"%@",path);
    
    // 偏好设置、用户信息、是否推送、是否支持 3G
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    
//    // 存储偏好数据
//    [data setObject:@"JackieQu" forKey:@"username"];
//    [data setObject:@"20" forKey:@"age"];
//    [data setInteger:185 forKey:@"height"];
//    // 马上存入本地
//    [data synchronize];
    
    // 从本地获取
    NSLog(@"%@",[data objectForKey:@"username"]);
    [data removeObjectForKey:@"age"];
    NSLog(@"%@",[data objectForKey:@"age"]);
}

@end