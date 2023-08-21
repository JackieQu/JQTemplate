//
//  JQDemoViewControllerD33_3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import "JQDemoViewControllerD33_3.h"
#import "JQHTTPManager.h"
#import "JQElmShopModel.h"
#import "JQElmShopCell.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>

static NSString *identifier = @"ShopCell";

@interface JQDemoViewControllerD33_3 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, assign) NSInteger page;

@end

@implementation JQDemoViewControllerD33_3

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_NAV_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[JQElmShopCell class] forCellReuseIdentifier:identifier];
        _tableView.rowHeight = 80;
    }
    return _tableView;
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
    
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 进入界面执行下拉刷新方法
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQElmShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.shop = self.dataList[indexPath.row];
    return cell;
}

// 下拉刷新数据
- (void)loadNewData {
    
    self.page = 1;
    
    [self loadData];
}

// 上拉加载更多数据
- (void)loadMoreData {
    
    self.page += 1;
    
    [self loadData];
}

// 加载数据
- (void)loadData {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",SERVER_HOST,API_GetRestaurantList];
    
    NSDictionary *params = @{
                              @"extras[]":@"restaurant_activity",
                              @"full_image_path":@"1",
                              @"geohash":@"wx4u14w0649y",
                              @"limit":@(kShopPageLimit),
                              @"offset":@(kShopPageLimit * (self.page - 1)),
                              @"type":@"geohash"
                            };
    
    [[JQHTTPManager shared] requestWithPath:urlString method:JQHTTPRequestGet parameters:params prepare:^{
        [self prepareExecuteAction];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self successActionWithTask:task obj:responseObject];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self failureActionWithTask:task error:error];
    }];
}

// 处理准备、成功、失败逻辑
- (void)prepareExecuteAction {
 
    [JQHUDHelper showProgressMessage:@"正在刷新"];
}

- (void)successActionWithTask:(NSURLSessionDataTask *)task obj:(id)obj {
    
    // JSON -> MODEL 有很多框架，原理都是 KVC
    // MJExtenstion、JsonModel、Mantle、YYModel 等
    
    NSArray *shopList = [JQElmShopModel mj_objectArrayWithKeyValuesArray:obj];
    
    if (shopList.count == 0) {
        
        // 显示已经全部加载完毕
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    if (self.page == 1) {
        
        // 获取最新数据后清空之前的数据源
        [self.dataList removeAllObjects];
        
        [self.dataList addObjectsFromArray:shopList];
        
        [self.tableView reloadData];
        
        // 重置没有更多数据的状态
        [self.tableView.mj_footer resetNoMoreData];
        
        // 结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
    } else {
        
        [self.dataList addObjectsFromArray:shopList];
        
        [self.tableView reloadData];
        
        // 结束上拉加载
        [self.tableView.mj_footer endRefreshing];
    }
    
    [JQHUDHelper showSuccessMessage:@"请求成功"];
}

- (void)failureActionWithTask:(NSURLSessionDataTask *)task error:(NSError *)error {
    
    JQLog(@"failure - %@",error);
    
    // 重置没有更多数据的状态
    [self.tableView.mj_footer resetNoMoreData];
    
    if (self.page == 1) {
        
        [self.tableView.mj_header endRefreshing];
        
    } else {
        
        [self.tableView.mj_footer endRefreshing];
        
    }
    
    [JQHUDHelper showErrorMessage:@"请求失败"];
}

@end
