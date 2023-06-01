//
//  JQDemoViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQDemoViewController.h"

static NSString *kRows      = @"rows";
static NSString *kTitle     = @"title";
static NSString *kClassName = @"className";
static NSString *kCellID    = @"identifier";

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
            @{kTitle: @"UIView",         kRows: @[
                @{kTitle: @"UIView",         kClassName: @"JQDemoViewControllerD1"},
            ]},
            @{kTitle: @"UILabel",        kRows: @[
                @{kTitle: @"UILabel",        kClassName: @"JQDemoViewControllerD2"},
            ]},
            @{kTitle: @"UIImageView",    kRows: @[
                @{kTitle: @"UIImageView",    kClassName: @"JQDemoViewControllerD3"},
            ]},
            @{kTitle: @"UIButton",       kRows: @[
                @{kTitle: @"UIButton",       kClassName: @"JQDemoViewControllerD4"},
            ]},
            @{kTitle: @"UITextField",    kRows: @[
                @{kTitle: @"UITextField",    kClassName: @"JQDemoViewControllerD5"},
            ]},
            @{kTitle: @"其他常用控件",    kRows: @[
                @{kTitle: @"其他常用控件",    kClassName: @"JQDemoViewControllerD6"},
            ]},
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
    
    NSDictionary *dict = self.dataList[section];
    NSMutableArray *rows = [dict mutableArrayValueForKey:kRows];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
    }
    
    NSDictionary *dict = self.dataList[indexPath.section];
    NSMutableArray *rows = [dict mutableArrayValueForKey:kRows];
    cell.textLabel.text = [rows[indexPath.row] valueForKey:kTitle];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSDictionary *dict = self.dataList[section];
    NSString *title = [NSString stringWithFormat:@"%ld-%@", section + 1, [dict valueForKey:kTitle]];
    return title;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.dataList[indexPath.section];
    NSMutableArray *rows = [dict mutableArrayValueForKey:kRows];
    NSString *clsName = [rows[indexPath.row] valueForKey:kClassName];
    Class cls = NSClassFromString(clsName);
    if (cls) {
        JQBaseViewController *vc = [[cls alloc] init];
        vc.title = [dict valueForKey:kTitle];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
