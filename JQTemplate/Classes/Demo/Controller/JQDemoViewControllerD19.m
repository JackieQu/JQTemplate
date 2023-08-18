//
//  JQDemoViewControllerD19.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQDemoViewControllerD19.h"
#import "JQPersonModel.h"
#import "JQDemoViewControllerD19_2.h"

@interface JQDemoViewControllerD19 () <UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchVC;
@property (nonatomic, strong) NSMutableArray *searchdDataList;
@property (nonatomic, strong) NSArray *resultList;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation JQDemoViewControllerD19

- (NSMutableArray *)searchdDataList {
    
    if (!_searchdDataList) {
        _searchdDataList = [NSMutableArray array];
        for (NSInteger i = 0; i < 30; i ++) {
            NSString *str = [NSString    stringWithFormat:@"test_%04d",arc4random_uniform(10000)];
            [_searchdDataList addObject:str];
        }
    }
    return _searchdDataList;
}

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        NSArray *names = @[@"小黑",@"小白",@"小红",@"小绿",@"大白"];
        NSArray *ages = @[@20,@21,@22,@23,@24];
        for (NSInteger i = 0; i < names.count; i ++) {
            JQPersonModel *person = [[JQPersonModel alloc] init];
            person.name = names[i];
            person.age = [ages[i] integerValue];
            [_dataList addObject:person];
        }
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction)];
    
    JQDemoViewControllerD19_2 *resultVC = [[JQDemoViewControllerD19_2 alloc] initWithStyle:UITableViewStylePlain];
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:resultVC];
    self.searchVC.searchResultsUpdater = self;
    self.searchVC.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationItem.searchController = self.searchVC;

    self.navigationItem.hidesSearchBarWhenScrolling = NO;
//    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
//    [self filter1];   // 1.比较运算符
//    [self filter2];   // 2.范围查询
//    [self filter3];   // 3.头尾查询
//    [self filter4];   // 4.包含查询
//    [self filter5];   // 5.模糊查询
//    [self filter6];   // 6.字符串本身查询
    [self filter7];   // 7.正则表达式查询
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchdDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.searchdDataList[indexPath.row];
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 获取搜索文字
    NSString *searchStr = searchController.searchBar.text;
    // 利用谓词搜索，设置谓词格式
    // [c] 不区分大小写
    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchStr];
    self.resultList = [self.searchdDataList filteredArrayUsingPredicate:p];
    
    if (searchController.searchResultsController) {
        JQDemoViewControllerD19_2 *resultsVC = (JQDemoViewControllerD19_2 *)searchController.searchResultsController;
        resultsVC.searchResults = self.resultList;
        if (resultsVC.tableView.top >= 0) {
            resultsVC.tableView.height += NAV_BAR_HEIGHT;
        }
        resultsVC.tableView.top = -NAV_BAR_HEIGHT;
        [resultsVC.tableView reloadData];
    }
}

- (void)searchAction {
    
    /*
    // 创建用于显示搜索结果的视图控制器
    SearchResultsViewController *resultsVC = [[SearchResultsViewController alloc] initWithStyle:UITableViewStylePlain];
    // 初始化 UISearchController
     UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:resultsVC];
    // 设置代理
    searchController.searchResultsUpdater = self;
    // 页面跳转
    [self presentViewController:searchController animated:YES completion:nil];
     */
    
    [self presentViewController:self.searchVC animated:YES completion:nil];
//    [self.navigationController pushViewController:self.searchVC animated:YES];
}

- (void)showFilteredData:(NSPredicate *)predicate {
    
    NSArray *personList = [self.dataList filteredArrayUsingPredicate:predicate];
    
    for (JQPersonModel *person in personList) {
        
        NSLog(@"%@",person.name);
    }
}

- (void)filter1 {
    
    /*
     Cocoa 框架中的 NSPredicate 用于查询，原理和用法的类似 SQL 的 where，作用相当于数据库的过滤
     
     谓词语法
     %@ 是对值为字符串、数字或日期的对象的替换值
     %K 是 key path 的替换值
     
     1. 比较运算符 >, <, ==, >=, <=, !=
     运算符可以同逻辑运算符一起使用，&&, ||, AND, OR, 谓词不区分大小写
     
     NSPredicate *p = [NSPredicate predicateWithFormat:@"name == '小红'"];
     NSPredicate *p = [NSPredicate predicateWithFormat:@"age <= 20"];
     NSPredicate *p = [NSPredicate predicateWithFormat:@"%K <= %@",@"age",@"30"];
     */
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"age >= 20 && name == '小白'"];
    
    // 根据谓词要求返回相应数组
//    [self.dataList filterUsingPredicate:p];
    
    [self showFilteredData:p];
}

- (void)filter2 {
    
    /*
     IN: 等于 SQL 的 IN 操作，左边的表达必须出现在右边指定的集合中
     BETWEEN: 左边的表达式等于右边表达式的值，或者介于它们之间，右边是一个有两个指定上限和下限的数值数列（指定顺序的数列）
     
     NSPredicate *p = [NSPredicate predicateWithFormat@"age in {20, 30}"];
     NSPredicate *p = [NSPredicate predicateWithFormat@"age in {20, %@, 30}", @25];
     */
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"age BETWEEN {22, 24}"];
    
    [self showFilteredData:p];
}

- (void)filter3 {
    
    /*
     BEGINSWITH: 以 xxx 开头
     ENDSWITH:   以 xxx 结尾
     */
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"name BEGINSWITH '大' || name ENDSWITH %@",@"白"];
    
    [self showFilteredData:p];
}

- (void)filter4 {
    
    /*
     CONTAINS: 左边的表达式包含右边的表达式
     
     NSPredicate *p = [NSPredicate predicateWithFormat:@"%K CONTAINS %@",@"name",@"白"];
     */
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"%K CONTAINS '白'",@"name"];
    
    [self showFilteredData:p];
}

- (void)filter5 {
    
    /*
     LIKE: 左边的表达式等于右边的表达式
     * 表示零个或多个字符
     ? 表示一个字符
     
     NSPredicate *p = [NSPredicate predicateWithFormat:@"name LIKE '*黑*'"];
     */
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"name LIKE '?黑*'"];
    
    [self showFilteredData:p];
}

- (void)filter6 {
    
    // 字符串本身查询，数组中每项都为字符串，才能用 SELF 查询
    // NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF = '小白'"];
    
    NSArray *names = @[@"小黑",@"小白",@"小红",@"小绿",@"大白"];
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"红"];
    
    NSArray *nameList = [names filteredArrayUsingPredicate:p];
    
    for (NSString *name in nameList) {
        
        NSLog(@"%@",name);
    }
}

- (void)filter7 {
    
    /*
     MATCHES: 正则匹配
     
     测试匹配手机号码，号段数据截止至 2018-09-01
     ***********************************
     移动号段：134、135、136、137、138、139、
             147、148、
             150、151、152、157、158、159、
             172、178、
             182、183、184、187、188、
             198
     ***********************************
     联通号段：130、131、132、
             145、146、
             155、156、
             166、
             171、175、176、
             185、186
     ***********************************
     电信号段：133、
             149、
             153、
             173、174、177、
             180、181、189、
             199
     ***********************************
     虚拟运营：170
     
     13\\d{9}
     14[5-9]\\d{8}
     15[^4,\\D]\\d{8}
     166\d{8}
     17[^9,\\D]\\d{8}
     18\d{9}
     19[8,9]\\d{8}
     
     粗略匹配：^1+[3456789]+\\d{9}";
     */
    
    NSString *pattern = @"^((1[3,8][0-9])|(14[5-9])|(15[^4,\\D])|(166)|(17[^9,\\D])|(19[8,9]))\\d{8}$";
    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    NSArray *nums = @[
                       @"13166666666",@"13a77777777",@"14799999999",@"14422222222",@"15566666666",
                       @"15433333333",@"16622222222",@"18333333333",@"19766666666",@"13287654321"
                       ];
    
    for (NSString *num in nums) {
        
        // 传入对象是否匹配正则表达式的谓词
        BOOL isTelNum = [p evaluateWithObject:num];
        
        if (isTelNum) {
            NSLog(@"%@: YES",num);
        } else {
            NSLog(@"%@: NO",num);
        }
    }
}

@end
