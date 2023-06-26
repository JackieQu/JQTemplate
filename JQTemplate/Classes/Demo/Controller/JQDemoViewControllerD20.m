//
//  JQDemoViewControllerD20.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/25.
//

#import "JQDemoViewControllerD20.h"
#import "JQWeiboCell.h"

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
        NSArray *weiboList = [JQWeiboModel loadWeiboData];
        for (JQWeiboModel *weibo in weiboList) {
            JQWeiboFrame *frame = [[JQWeiboFrame alloc] init];
            frame.weibo = weibo;
            [_dataList addObject:frame];
        }
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[JQWeiboCell class] forCellReuseIdentifier:identifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.weiboFrame = self.dataList[indexPath.row];
    return cell;
    
    /*
     预估行高
     
    QPWeiBoEstimateHeightCell * cell = [tableView dequeueReusableCellWithIdentifier:testIdentifier];
    
    CGFloat height = [cell bindDataWithWeiBoModel:self.testDataList[indexPath.row]];
    
    if (!self.cellHeightDict[indexPath]) {
        
//        [self.cellHeightDict setObject:@(height) forKey:indexPath];
        
        // 或者用字面量写法
        self.cellHeightDict[indexPath] = @(height);
    }
    return cell;
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQWeiboFrame *weiboFrame = self.dataList[indexPath.row];
    return weiboFrame.cellHeight;
    
    /*
     预估行高
     
    return [self.cellHeightDict[indexPath] doubleValue];
     */
}

@end
