//
//  JQDemoViewControllerD8.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/2.
//

#import "JQDemoViewControllerD8.h"

#import "JQBaseTabBarController.h"
#import "JQBaseNavigationController.h"
#import "JQBaseViewController.h"

@interface JQDemoViewControllerD8 ()

@end

@implementation JQDemoViewControllerD8

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    JQLog(@"modal - %@",self.presentedViewController);
    JQLog(@"modal - %@",self.presentingViewController);
    
//    JQBaseTabBarController *tabBarVC = (JQBaseTabBarController *)self.presentingViewController;
//    JQBaseNavigationController *navVC = tabBarVC.viewControllers[0];
//    JQBaseViewController *vc = (JQBaseViewController *)navVC.topViewController;
//    vc.title = @"TEST";
    
    if ([self.callbackDelegate respondsToSelector:@selector(callbackObject:)]) {
        [self.callbackDelegate callbackObject:@"TEST"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
