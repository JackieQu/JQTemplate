//
//  JQDemoViewControllerD20.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/25.
//

#import "JQDemoViewControllerD20.h"
#import "JQWeiboModel.h"

static NSString *identifier = @"JQWeiboCell";
static NSString *estimateHeightIdentifier = @"JQWeiboCellEstimateHeightCell";

@interface JQDemoViewControllerD20 ()

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *estimateHeightDataList;

@end

@implementation JQDemoViewControllerD20

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        _dataList = [NSMutableArray arrayWithArray:[JQWeiboModel loadWeiboData]];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
