//
//  JQDemoViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQDemoViewController.h"
#import "JQModalDelegate.h"
#import "JQDemoTableModel.h"

static NSString *kCellID    = @"identifier";

@interface JQDemoViewController () <UITableViewDataSource, UITableViewDelegate, JQModalDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<JQDemoSectionModel *> *dataList;

@end

@implementation JQDemoViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_NAV_HEIGHT - TAB_BAR_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = [JQDemoTableModel tableModel].sections;
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_NAV_HEIGHT - TAB_BAR_HEIGHT);
}

- (void)initUI {
    [super initUI];
    
    [self.view addSubview:self.tableView];
    
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
    if (cls) {
        JQBaseViewController *vc = [[cls alloc] init];
        vc.title = item.title;
        if (item.flag) {
            vc.modalDelegate = self;
            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:YES completion:^{
                JQLog(@"%@", self.presentedViewController);
                JQLog(@"%@", self.presentingViewController);
            }];
        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } else {
        
        NSString *bundleKey = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleExecutableKey];
        NSString *vcName = [NSString stringWithFormat:@"%@.%@", bundleKey, item.className];
        Class swiftCls = NSClassFromString(vcName);
        if (swiftCls) {
            JQBaseViewController *vc = [[swiftCls alloc] init];
            vc.title = item.title;
            if (item.flag) {
                vc.modalDelegate = self;
                vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self presentViewController:vc animated:YES completion:nil];
            } else {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    
    [tableView setUserInteractionEnabled:YES];
}

#pragma mark - JQModalDelegate Methods

- (void)passObject:(NSObject *)object {
  
    self.title = [NSString stringWithFormat:@"%@", object];
}

@end
