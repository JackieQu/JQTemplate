//
//  JQDemoViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQDemoViewController.h"
#import "JQModalDelegate.h"

static NSString *kRows      = @"rows";
static NSString *kTitle     = @"title";
static NSString *kClassName = @"className";
static NSString *kCellID    = @"identifier";

@interface JQDemoViewController () <UITableViewDataSource, UITableViewDelegate, JQModalDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

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
            @{kTitle: @"其他常用控件",      kRows: @[
                @{kTitle: @"其他常用控件",    kClassName: @"JQDemoViewControllerD6"},
            ]},
            @{kTitle: @"简单动画",         kRows: @[
                @{kTitle: @"自定义指示器",    kClassName: @"JQDemoViewControllerD7"},
                @{kTitle: @"简单动画",        kClassName: @"JQDemoViewControllerD7"},
                @{kTitle: @"基本动画",        kClassName: @"JQDemoViewControllerD7"},
                @{kTitle: @"转场动画",        kClassName: @"JQDemoViewControllerD7"},
                @{kTitle: @"动画应用",        kClassName: @"JQDemoViewControllerD7"},
            ]},
            @{kTitle: @"视图控制器",       kRows: @[
                @{kTitle: @"生命周期",       kClassName: @"JQBaseViewController"},
                @{kTitle: @"模态视图",       kClassName: @"JQDemoViewControllerD8",  @"flag": @(1)},
            ]},
            @{kTitle: @"导航控制器",       kRows: @[
                @{kTitle: @"导航控制器",      kClassName: @"JQDemoViewControllerD9"},
                @{kTitle: @"自定义导航栏",    kClassName: @"JQDemoViewControllerD9"},
            ]},
            @{kTitle: @"整理补充",         kRows: @[
                @{kTitle: @"UIBarButtonItem补充", kClassName: @"JQDemoViewControllerD10"},
                @{kTitle: @"UITextField补充", kClassName: @"JQDemoViewControllerD10"},
            ]},
            @{kTitle: @"标签控制器",       kRows: @[
                @{kTitle: @"标签控制器",      kClassName: @"JQDemoViewControllerD11"},
                @{kTitle: @"Nav+TabBar",    kClassName: @"JQBaseTabBarController"},
                @{kTitle: @"自定义标签栏",    kClassName: @"JQDemoViewControllerD11"},
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
    NSMutableArray *rows = [dict mutableArrayValueForKey:kRows];
    if (rows.count <= 1) {
        return nil;
    }
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
        vc.title = [rows[indexPath.row] valueForKey:kTitle];
        BOOL flag = [[rows[indexPath.row] valueForKey:@"flag"] intValue] == 1;
        if (flag) {
            vc.modalDelegate = self;
            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:YES completion:^{
                JQLog(@"%@", self.presentedViewController);
                JQLog(@"%@", self.presentingViewController);
            }];
        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - JQModalDelegate Methods

- (void)passObject:(NSObject *)object {
  
    self.title = [NSString stringWithFormat:@"%@", object];
}

@end
