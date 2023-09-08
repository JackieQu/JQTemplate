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
#import "UITabBar+Badge.h"

@interface JQBaseTabBarController () <JQCustomTabBarDelegate>

@property (nonatomic, strong) JQCustomTabBar *customTabBar;

@end

@implementation JQBaseTabBarController

- (JQCustomTabBar *)customTabBar {
    
    if (!_customTabBar) {
        _customTabBar = [[JQCustomTabBar alloc] initWithFrame:self.tabBar.bounds];
//        __weak typeof(self) weakSelf = self;
//        _customTabBar.block = ^(JQCustomTabBar * _Nonnull tabBar, JQCustomButtonTag tag) {
//            [weakSelf handleAction:tabBar selectedIndex:tag];
//        };
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
    
    NSMutableArray *viewControllers = [self.customTabBar.tabBarModel.availableItems mutableCopy];
    for (NSInteger i = 0; i < viewControllers.count; i ++) {
        JQTabBarItemModel *item = viewControllers[i];
        JQBaseViewController *vc = [[item.cls alloc] init];
        vc.title = item.title;
        JQBaseNavigationController *navVC = [[JQBaseNavigationController alloc] initWithRootViewController:vc];
        [viewControllers replaceObjectAtIndex:i withObject:navVC];
    }
    self.viewControllers = viewControllers;
    self.selectedIndex = self.customTabBar.tabBarModel.selectedIndex;
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = self.customTabBar.backgroundColor;
    self.tabBar.translucent = NO;
    [self.tabBar addSubview:self.customTabBar];
    
//    NSInteger i = 2;
//    if (self.customTabBar.tabBarModel.isSpecial && self.customTabBar.tabBarModel.specialIndex != i) {
//        [self.tabBar showBadgeAtIndex:i];
//    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.customTabBar.frame = self.tabBar.bounds;
    self.customTabBar.height -= SAFE_BOTTOM;
}

- (void)handleAction:(JQCustomTabBar *)tabBar selectedIndex:(NSInteger)index {
    
    if (index == kSpecialTag) {
        JQBaseViewController *vc = [[tabBar.tabBarModel.specialItem.cls alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    } else if (index != self.selectedIndex) {
        self.selectedIndex = index;
    }
}

#pragma mark - JQCustomTabBarDelegate

- (void)tabBar:(JQCustomTabBar *)tabBar selectedAtIndex:(JQCustomButtonTag)tag {
    
    [self handleAction:tabBar selectedIndex:tag];
}

@end
