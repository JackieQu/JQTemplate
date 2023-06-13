//
//  JQDemoViewControllerD16.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQDemoViewControllerD16.h"

@interface JQDemoViewControllerD16 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSArray *headerList;
@property (nonatomic, strong) NSArray *footerList;

@end

@implementation JQDemoViewControllerD16

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.sectionHeaderHeight = 30;
    tableView.sectionFooterHeight = 30;
    [self.view addSubview:tableView];
    
    NSArray *arr1 = @[@"A",@"B",@"C"];
    NSArray *arr2 = @[@"X",@"Y",@"Z"];
    self.dataList = @[arr1, arr2];
    
    NSArray *headerList = @[@"1234",@"4321"];
    NSArray *footerList = @[@"4321",@"1234"];
    self.headerList = headerList;
    self.footerList = footerList;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr = self.dataList[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQLog(@"section:%@ row:%@",@(indexPath.section),@(indexPath.row));
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = self.dataList[indexPath.section][indexPath.row];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.headerList[section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    return self.footerList[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JQLog(@"%@",@(indexPath.row + 1));
}

@end
