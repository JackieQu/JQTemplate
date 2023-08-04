//
//  JQDemoViewControllerD18.m
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

#import "JQDemoViewControllerD18.h"
#import "JQMessageModel.h"
#import "JQMessageCell.h"
#import "JQShopModel.h"
#import "JQShopCell.h"

static NSString *baseUrl = @"http://127.0.0.1/images/";

static NSString *identifier = @"cellID";

@interface JQDemoViewControllerD18 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation JQDemoViewControllerD18

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
        /*
        [_tableView registerClass:[JQMessageCell class] forCellReuseIdentifier:identifier];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
        headerView.backgroundColor = [UIColor orangeColor];
        _tableView.tableHeaderView = headerView;
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
        footerView.backgroundColor = [UIColor cyanColor];
        _tableView.tableFooterView = footerView;
        _tableView.rowHeight = 80;
         */
        
        [_tableView registerClass:[JQShopCell class] forCellReuseIdentifier:identifier];
        _tableView.rowHeight = 80;
    }
    return _tableView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        /*
        _dataList = [JQMessageModel loadMessageData];
         */
        
        _dataList = [JQShopModel loadShopData];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    JQMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    JQMessageModel *message = self.dataList[indexPath.row];
    cell.message = message;
    return cell;
     */
    
    JQShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    JQShopModel *shop = self.dataList[indexPath.row];
    cell.shop = shop;
    
    // 为了避免重复加载的问题，创建了一个 downloadImage，属于数据源，当 tableView 滚动时给 cell 的数据赋值
    if (shop.downloadedImage) {
        // 如下载过，直接从内存中获取图片
        cell.iconView.image = shop.downloadedImage;
    } else {
        // 如未下载，先设置默认图片，再开启异步线程
        cell.iconView.image = [UIImage imageNamed:@"defaultImage"];
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            // 模拟网络延时
            [NSThread sleepForTimeInterval:2];
            // 通过 url 获取网络数据
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,shop.shop_image]]];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://s.cn.bing.net/th?id=OHR.GothicRuins_ZH-CN8317467997_UHD.jpg"]];
            // 将数据转为图片
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                // 通知 model，将图片赋值给 downloadImage，以便下次从内存获取
                shop.downloadedImage = image;
                // 获取主队列，更新 UI
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // 刷新当前单元格
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }
        }];
        // 将请求加入全局队列
        [self.queue addOperation:op];
    }

    return cell;
}

@end
