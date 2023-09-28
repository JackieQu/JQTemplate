//
//  JQDemoViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQDemoViewController.h"
#import "JQDemoTableModel.h"
#import "JQCallbackDelegate.h"

static NSString *kCellID = @"identifier";

@interface JQDemoViewController () <UITableViewDataSource, UITableViewDelegate, JQCallbackDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<JQDemoSectionModel *> *dataList;

@end

@implementation JQDemoViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
}

- (void)initUI {
    [super initUI];
    
    [self.view addSubview:self.tableView];
}

- (void)loadData {
    
    self.dataList = [JQDemoTableModel tableModel].sections;
    [self.tableView reloadData];
//    [self scrollToLastCell];
}

- (void)scrollToLastCell {
    
    NSInteger lastSection = self.dataList.count - 1;
    NSInteger lastRow = self.dataList[lastSection].rows.count - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:lastSection];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray<JQDemoRowModel *> *rows = self.dataList[section].rows;
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
    }
    NSArray<JQDemoRowModel *> *rows = self.dataList[indexPath.section].rows;
    JQDemoRowModel *item = rows[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
//    NSArray<JQDemoRowModel *> *rows = self.dataList[section].rows;
//    if (rows.count <= 1) {
//        return nil;
//    }
    NSString *title = [NSString stringWithFormat:@"%ld-%@", section + 1, self.dataList[section].title];
    return title;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView setUserInteractionEnabled:NO];
    
    NSArray<JQDemoRowModel *> *rows = self.dataList[indexPath.section].rows;
    JQDemoRowModel *item = rows[indexPath.row];
    Class cls = NSClassFromString(item.className);
    if (!cls) {
        NSString *bundleKey = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleExecutableKey];
        NSString *vcName = [NSString stringWithFormat:@"%@.%@", bundleKey, item.className];
        cls = NSClassFromString(vcName);
    }
    if (cls) {
        JQBaseViewController *vc = [[cls alloc] init];
        vc.title = item.title;
        vc.callbackDelegate = self;
        if (item.flag) {
            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:YES completion:^{
                JQLog(@"%@", self.presentedViewController);
                JQLog(@"%@", self.presentingViewController);
            }];
        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    [tableView setUserInteractionEnabled:YES];
}

#pragma mark - JQCallbackDelegate Methods

- (void)callbackObject:(NSObject *)object {
  
    self.title = [NSString stringWithFormat:@"%@", object];
}

@end
