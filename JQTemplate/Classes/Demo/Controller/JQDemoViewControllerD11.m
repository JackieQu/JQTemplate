//
//  JQDemoViewControllerD11.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "JQDemoViewControllerD11.h"
#import "UITabBar+Badge.h"

@interface JQDemoViewControllerD11 ()

@end

@implementation JQDemoViewControllerD11

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tabBar.tintColor = [UIColor brownColor];
    self.tabBar.barTintColor = [UIColor cyanColor];
    
    UIViewController *vc0 = [[UIViewController alloc] init];
    vc0.view.backgroundColor = [UIColor redColor];
    vc0.tabBarItem.title = @"主页";
    vc0.tabBarItem.image = [UIImage imageNamed:@"tab_0"];
    vc0.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_c0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:100];
    item.badgeValue = @"5";
    vc0.tabBarItem = item;
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor orangeColor];
    vc1.tabBarItem.title = @"收藏";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tab_1"];
    vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_1_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    vc2.tabBarItem.title = @"动态";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tab_2"];
    vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_2_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.badgeValue = @"10";
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor greenColor];
    vc3.tabBarItem.title = @"设置";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tab_3"];
    vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_3_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.viewControllers = @[vc0, vc1, vc2, vc3];
    
    [self.tabBar showBadgeAtIndex:0];
    [self.tabBar showBadgeAtIndex:1];
    [self.tabBar hideBedgeAtIndex:4];
}

@end
