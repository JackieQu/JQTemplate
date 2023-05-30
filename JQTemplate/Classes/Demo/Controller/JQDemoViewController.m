//
//  JQDemoViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQDemoViewController.h"

static NSString *title     = @"title";
static NSString *className = @"className";
static NSString *cellID    = @"identifier";

@interface JQDemoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation JQDemoViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        NSArray *arr = @[
            @{title: @"UIView",  className: @"JQDemoViewControllerD1"},
            @{title: @"UILabel", className: @"JQDemoViewControllerD2"},
            @{title: @"UIImageView", className: @"JQDemoViewControllerD3"},
        ];
        _dataList = [NSMutableArray arrayWithArray:arr];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    [super initUI];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDictionary *dict = self.dataList[indexPath.row];
    cell.textLabel.text = [dict valueForKey:title];
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.dataList[indexPath.row];
    NSString *clsName = [dict valueForKey:className];
    Class cls = NSClassFromString(clsName);
    if (cls) {
        JQBaseViewController *vc = [[cls alloc] init];
        vc.title = [dict valueForKey:title];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
