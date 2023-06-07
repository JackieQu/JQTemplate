//
//  JQBaseTabBarController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQBaseTabBarController.h"
#import "JQBaseViewController.h"
#import "JQBaseNavigationController.h"

@interface JQBaseTabBarController ()

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation JQBaseTabBarController

- (NSArray *)dataList {
    
    if (!_dataList) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        NSArray *titleArr = @[@"演示", @"首页", @"我的"];
        NSArray *clsNameArr = @[@"JQDemoViewController", @"JQHomeViewController", @"JQProfileViewController"];
        for (NSUInteger i = 0; i < clsNameArr.count; i ++) {
            NSString *clsName = clsNameArr[i];
            Class cls = NSClassFromString(clsName);
            if (cls) {
                JQBaseViewController *vc = [[cls alloc] init];
                vc.title = titleArr[i];
                JQBaseNavigationController *navVC = [[JQBaseNavigationController alloc] initWithRootViewController:vc];
                [tmpArr addObject:navVC];
            }
        }
        _dataList = tmpArr;
    }
    return _dataList;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.viewControllers = self.dataList;
//    if (self.vcArr.count >= 2) {
//        self.selectedIndex = 1;
//    }
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
