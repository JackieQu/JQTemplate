//
//  JQBaseNavigationController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQBaseNavigationController.h"

@interface JQBaseNavigationController ()

@end

@implementation JQBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationBar.layer.shadowColor = nil;
    self.navigationBar.layer.shadowOpacity = 0.0f;
    self.navigationBar.layer.shadowOffset = CGSizeZero;
    self.navigationBar.layer.shadowRadius = 0.0f;;
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont systemFontOfSize:17.0]
    };;
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    appearance.layer.shadowColor = self.navigationBar.layer.shadowColor;
    appearance.layer.shadowOpacity = self.navigationBar.layer.shadowOpacity;
    appearance.layer.shadowOffset = self.navigationBar.layer.shadowOffset;
    appearance.layer.shadowRadius = self.navigationBar.layer.shadowRadius;
    appearance.translucent = NO;
    appearance.tintColor = self.navigationBar.tintColor;
    appearance.barTintColor = self.navigationBar.barTintColor;
    appearance.shadowImage = self.navigationBar.shadowImage;
    appearance.titleTextAttributes = self.navigationBar.titleTextAttributes;
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barAppperance = [[UINavigationBarAppearance alloc]init];
        [barAppperance configureWithOpaqueBackground];
        barAppperance.backgroundColor = self.navigationBar.barTintColor;
        barAppperance.shadowColor = [UIColor colorWithCGColor:self.navigationBar.layer.shadowColor];
        barAppperance.shadowImage = self.navigationBar.shadowImage;
        barAppperance.titleTextAttributes = self.navigationBar.titleTextAttributes;

        appearance.standardAppearance = barAppperance;
        appearance.scrollEdgeAppearance = barAppperance;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
        item.title = @"返回";
        viewController.navigationItem.backBarButtonItem = item;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    
    return self.topViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.topViewController.preferredStatusBarStyle;
}

@end
