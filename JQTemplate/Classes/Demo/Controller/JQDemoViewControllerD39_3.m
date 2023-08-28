//
//  JQDemoViewControllerD39_3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/25.
//

#import "JQDemoViewControllerD39_3.h"
#import <RESideMenu/RESideMenu.h>

@interface JQDemoViewControllerD39_3 () <UITableViewDataSource, UITableViewDelegate>

{
    NSMutableArray *dataList;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JQDemoViewControllerD39_3

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 80;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataList = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
    self.title = @"第一页";
    self.view.backgroundColor = [UIColor randomColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleDone target:self action:@selector(leftMenuAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.view addSubview:self.tableView];
}

- (void)leftMenuAction {
    
    // 显示左侧侧拉菜单
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = dataList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [dataList removeObjectAtIndex:indexPath.row];
    
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {

    return @"删除";
}

@end
