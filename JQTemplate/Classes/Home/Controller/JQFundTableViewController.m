//
//  JQFundTableViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/12.
//

#import "JQFundTableViewController.h"

@interface JQFundTableViewController ()

@end

@implementation JQFundTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基金列表";
    self.dataList = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
}

- (NSInteger)jq_numberOfRowsInSection:(NSInteger)section {
    
//    return self.dataList.count;
    return 50;
}

- (UITableViewCell *)jq_cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor randomColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    return cell;
}

- (CGFloat)jq_heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ADAPT_VALUE(50);
}

- (void)jq_didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQLog(@"%@", indexPath);
}

@end
