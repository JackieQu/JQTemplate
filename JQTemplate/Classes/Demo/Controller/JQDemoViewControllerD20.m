//
//  JQDemoViewControllerD20.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/25.
//

#import "JQDemoViewControllerD20.h"
#import "JQWeiboCell.h"
#import "JQWeiboEstimateHeightCell.h"

static NSString *identifier = @"JQWeiboCell";
static NSString *estimateHeightIdentifier = @"JQWeiboCellEstimateHeightCell";

@interface JQDemoViewControllerD20 ()

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSArray *estimateHeightDataList;
@property (nonatomic, strong) NSMutableDictionary *cellHeightDict;

@end

@implementation JQDemoViewControllerD20

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        NSArray *weiboList = [JQWeiboModel loadWeiboData];
        for (JQWeiboModel *weibo in weiboList) {
            JQWeiboFrame *frame = [[JQWeiboFrame alloc] init];
            frame.weibo = weibo;
            [_dataList addObject:frame];
        }
    }
    return _dataList;
}

- (NSArray *)estimateHeightDataList {
    
    if (!_estimateHeightDataList) {
        _estimateHeightDataList = [JQWeiboModel loadWeiboData];
    }
    return _estimateHeightDataList;
}

- (NSMutableDictionary *)cellHeightDict {
    
    if (!_cellHeightDict) {
        _cellHeightDict = [NSMutableDictionary dictionary];
    }
    return _cellHeightDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[JQWeiboCell class] forCellReuseIdentifier:identifier];
    
//    self.tableView.estimatedRowHeight = 120;
//    [self.tableView registerClass:[JQWeiboEstimateHeightCell class] forCellReuseIdentifier:estimateHeightIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
    
//    return self.estimateHeightDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.weiboFrame = self.dataList[indexPath.row];
    return cell;
    
//    JQWeiboEstimateHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:estimateHeightIdentifier];
//    CGFloat height = [cell cellHeightAfterBindData:self.estimateHeightDataList[indexPath.row]];
//    if (!self.cellHeightDict[indexPath]) {
////        [self.cellHeightDict setObject:@(height) forKey:indexPath];
//        self.cellHeightDict[indexPath] = @(height);
//    }
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQWeiboFrame *weiboFrame = self.dataList[indexPath.row];
    return weiboFrame.cellHeight;

//    return [self.cellHeightDict[indexPath] doubleValue];
}

@end
