//
//  JQDemoViewControllerD12.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/9.
//

#import "JQDemoViewControllerD12.h"
#import "AppDelegate.h"

@interface JQDemoViewControllerD12 ()

@end

@implementation JQDemoViewControllerD12

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIApplication *application = [UIApplication sharedApplication];
//    AppDelegate *appDelegate = (AppDelegate *)application.delegate;
//    [appDelegate saveContext];
    
//    application.networkActivityIndicatorVisible = YES;
//    application.applicationIconBadgeNumber = 0;
//
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
//    [application registerUserNotificationSettings:settings];
    
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    JQLog(@"window: %p", window);
//    
//    UIWindow *window2 = self.view.window;
//    JQLog(@"window2: %p", window2);
//    
//    window2.rootViewController = [[JQBaseViewController alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    // http: https: ftp: // safiri
    // sms: // 发短信
    // tel: // 打电话
    // mailto:
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
