//
//  JQBaseTabBarController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQBaseTabBarController.h"
#import "JQBaseViewController.h"
#import "JQBaseNavigationController.h"
#import "JQCustomTabBar.h"

@interface JQBaseTabBarController () <JQCustomTabBarDelegate>

@property (nonatomic, strong) JQCustomTabBar *customTabBar;

@end

@implementation JQBaseTabBarController

- (JQCustomTabBar *)customTabBar {
    
    if (!_customTabBar) {
        _customTabBar = [[JQCustomTabBar alloc] initWithFrame:self.tabBar.bounds];
        __weak typeof(self) weakSelf = self;
        _customTabBar.block = ^(JQCustomTabBar * _Nonnull tabBar, JQDockButtonType type) {
            [weakSelf handleAction:tabBar selectedIndex:type];
        };
        _customTabBar.delegate = self;
    }
    return _customTabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITabBar *appearance = [UITabBar appearance];
    appearance.backgroundImage = [UIImage new];
    appearance.shadowImage = [UIImage new];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.customTabBar.tabBarModel.availableItems];
    for (NSUInteger i = 0; i < viewControllers.count; i ++) {
        JQTabBarItemModel *item = viewControllers[i];
        JQBaseViewController *vc = [[item.cls alloc] init];
        vc.title = item.title;
        JQBaseNavigationController *navVC = [[JQBaseNavigationController alloc] initWithRootViewController:vc];
        [viewControllers replaceObjectAtIndex:i withObject:navVC];
    }
    self.viewControllers = viewControllers;
    self.selectedIndex = self.customTabBar.tabBarModel.selectedIndex;

    self.tabBar.translucent = NO;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = self.customTabBar.backgroundColor;
    [self.tabBar addSubview:self.customTabBar];
//    [self setValue:self.customTabBar forKey:@"tabBar"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.customTabBar.frame = self.tabBar.bounds;
}

- (void)handleAction:(JQCustomTabBar *)tabBar selectedIndex:(NSUInteger)idx {
    
    if (idx == kSpecialTag) {
        JQBaseViewController *vc = [[tabBar.tabBarModel.specialItem.cls alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    } else if (idx != self.selectedIndex) {
        self.selectedIndex = idx;
    }
}

#pragma mark - JQCustomTabBarDelegate

- (void)tabBar:(JQCustomTabBar *)tabBar selectedAtIndex:(JQDockButtonType)type {
    
    [self handleAction:tabBar selectedIndex:type];
}


@end
