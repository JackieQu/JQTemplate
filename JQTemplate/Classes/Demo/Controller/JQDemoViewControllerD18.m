//
//  JQDemoViewControllerD18.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQDemoViewControllerD18.h"
#import "JQMessageModel.h"
#import "JQMessageCell.h"
#import "JQShopModel.h"
#import "JQShopCell.h"

static NSString *identifier = @"cellID";

@interface JQDemoViewControllerD18 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation JQDemoViewControllerD18

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
    cell.shop = self.dataList[indexPath.row];
    return cell;
}

@end
