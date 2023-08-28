//
//  JQDemoViewControllerD39_4.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/28.
//

#import "JQDemoViewControllerD39_4.h"
#import "JQLeftMenuModel.h"
#import <RESideMenu/RESideMenu.h>

@interface JQDemoViewControllerD39_4 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation JQDemoViewControllerD39_4

#pragma mark - getters and setters

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 150)];
        
        UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 90, 90)];
        headView.image = [UIImage imageNamed:@"defaultHead"];
        headView.layer.cornerRadius = 45;
        headView.clipsToBounds = YES;
        [_headerView addSubview:headView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headView.frame) + 10, headView.center.y + 10, 200, 20)];
        nameLabel.text = @"Jackie";
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:20];
        [_headerView addSubview:nameLabel];
    }
    return _headerView;
}

- (NSArray *)menuItems {
    
    if (!_menuItems) {
        
        JQLeftMenuModel *item1 = [[JQLeftMenuModel alloc] init];
        item1.target = @"FirstViewController";
        item1.title = @"第一页";
        item1.icon = @"feedback";
        
        JQLeftMenuModel *item2 = [[JQLeftMenuModel alloc] init];
        item2.target = @"SecondViewController";
        item2.title = @"第二页";
        item2.icon = @"feedback";
        
        JQLeftMenuModel *item3 = [[JQLeftMenuModel alloc] init];
        item3.target = @"ThirdViewController";
        item3.title = @"第三页";
        item3.icon = @"feedback";
        
        _menuItems = [NSArray arrayWithObjects:item1, item2, item3, nil];
    }
    return _menuItems;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    JQLeftMenuModel *item = [self.menuItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item.title];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:item.icon];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JQLeftMenuModel *item = self.menuItems[indexPath.row];
    
    // 设置选择侧拉菜单对应项的界面
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(item.target) alloc] init]] animated:YES];
    
    // 隐藏侧拉菜单
    [self.sideMenuViewController hideMenuViewController];
}

@end
