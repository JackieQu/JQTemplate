//
//  JQCarViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQCarViewController.h"
#import "JQCarGroupModel.h"

@interface JQCarViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation JQCarViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.height -= STATUS_NAV_HEIGHT;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50;
        _tableView.sectionIndexMinimumDisplayRowCount = 100;
        _tableView.sectionIndexColor = [UIColor blueColor];
        _tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *arr = [JQCarGroupModel loadCarGroupData];
    self.dataList = arr;
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    JQCarGroupModel *group = self.dataList[section];
    return group.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    JQCarGroupModel *group = self.dataList[indexPath.section];
    cell.textLabel.text = group.cars[indexPath.row];
    return cell;
     */
    
    static NSString *identifiter = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    JQCarGroupModel *group = self.dataList[indexPath.section];
    JQCarModel *car = group.cars[indexPath.row];
    cell.textLabel.text = car.name;
    cell.imageView.image = [UIImage imageNamed:car.icon];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        
    JQCarGroupModel *group = self.dataList[section];
    return group.title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [self.dataList valueForKey:@"title"];
}

@end
