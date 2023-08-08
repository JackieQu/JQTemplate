//
//  JQIndustryViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQIndustryViewController.h"
#import "JQIndustryModel.h"

@interface JQIndustryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation JQIndustryViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.height -= STATUS_NAV_HEIGHT;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 60;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _tableView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = [JQIndustryModel loadIndustryData];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *identifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    JQIndustryModel *industry = self.dataList[indexPath.row];
    cell.textLabel.text = industry.name;
    cell.detailTextLabel.text = industry.state;
    cell.imageView.image = [UIImage imageNamed:industry.icon];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
}

@end
