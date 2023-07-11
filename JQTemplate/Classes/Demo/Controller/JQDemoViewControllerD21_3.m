//
//  JQDemoViewControllerD21_3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/7.
//

#import "JQDemoViewControllerD21_3.h"
#import "UIImage+Color.h"

#define HeadHeight (200 - 64)

@interface JQDemoViewControllerD21_3 ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JQDemoViewControllerD21_3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自适应内边距
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInsetAdjustmentBehavior = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"标题";
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
    self.titleLabel = titleLabel;
    self.titleLabel.alpha = 0;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header"]];
    imageView.frame = CGRectMake(0, 0, 0, 200);
    self.tableView.tableHeaderView = imageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat percent = offsetY / HeadHeight;
    // alpha 若大于 1，显示 0.5
    if (percent >= 1) {
        percent = 0.99;
    }
    self.titleLabel.alpha = percent;
    // 通过类别将颜色转为图片
    UIColor *whiteColor = [UIColor colorWithWhite:1 alpha:percent];
    UIImage *whiteImage = [UIImage imageWithColor:whiteColor];
//    [self.navigationController.navigationBar setBackgroundImage:whiteImage forBarMetrics:UIBarMetricsDefault];
    UIImageView *testView = [[UIImageView alloc] initWithImage:whiteImage];
    testView.frame = self.tableView.tableHeaderView.bounds;
    self.tableView.tableHeaderView = testView;
}

@end
