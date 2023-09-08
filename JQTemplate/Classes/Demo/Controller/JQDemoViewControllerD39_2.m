//
//  JQDemoViewControllerD39_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/25.
//

#import "JQDemoViewControllerD39_2.h"
#import "JQLeftMenuModel.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>

@interface JQDemoViewControllerD39_2 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JQDemoViewControllerD39_2

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = [JQLeftMenuModel loadLeftMenuData];
    }
    return _dataList;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}

- (void)loadView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"bg_stars"];
    imageView.userInteractionEnabled = YES;
    self.view = imageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    JQLeftMenuModel *menu = self.dataList[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:menu.icon];
    
    cell.textLabel.text = menu.name;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JQLeftMenuModel *menu = self.dataList[indexPath.row];
    
    UIViewController *vc = [[NSClassFromString(menu.vcName) alloc] init];
    
    if (vc == nil) {
        
        JQLog(@"%@",menu.name);
        
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
        
        return;
    }
    
    vc.title = menu.name;
    
//    [[[UIApplication sharedApplication].windows.firstObject rootViewController].navigationController pushViewController:vc animated:YES];
    
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
}

@end
