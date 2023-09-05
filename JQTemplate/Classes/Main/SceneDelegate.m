//
//  SceneDelegate.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "JQBaseTabBarController.h"

#import <MMDrawerController/MMDrawerController.h>
#import <MMDrawerController/MMDrawerVisualState.h>
#import <RESideMenu/RESideMenu.h>

#import <UMShare/UMShare.h>

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    JQLogFunction
    
    UIWindowScene *windowScene = [[UIWindowScene alloc] initWithSession:session connectionOptions:connectionOptions];
//    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    self.window.rootViewController = [[JQBaseTabBarController alloc] init];
    
    /*
    UIViewController *centerVC = [[NSClassFromString(@"JQDemoViewControllerD39") alloc] init];
    centerVC.title = @"首页";
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:centerVC];
    UIViewController *leftVC = [[NSClassFromString(@"JQDemoViewControllerD39_2") alloc] init];
    UIViewController *rightVC = [[UIViewController alloc] init];
    rightVC.view.backgroundColor = [UIColor randomColor];
    MMDrawerController *drawerVC = [[MMDrawerController alloc] initWithCenterViewController:navC leftDrawerViewController:leftVC rightDrawerViewController:rightVC];
    // 打开抽屉的手势
    drawerVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    // 关闭抽屉的手势
    drawerVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    // 设置抽屉的阴影
    drawerVC.showsShadow = NO;
    // 设置抽屉的状态栏
    drawerVC.showsStatusBarBackgroundView = NO;
    // 设置抽屉的宽度
    drawerVC.maximumLeftDrawerWidth = 200;
    drawerVC.maximumRightDrawerWidth = 100;
    // 设置抽屉的效果
    [drawerVC setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [MMDrawerVisualState slideVisualStateBlock];
        if (block) {
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    self.window.rootViewController = drawerVC;
     */
    
    /*
    UIViewController *rootVC = [[NSClassFromString(@"JQDemoViewControllerD39_3") alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    UIViewController *leftMenuVC = [[NSClassFromString(@"JQDemoViewControllerD39_4") alloc] init];
    
    // 创建侧拉菜单
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:navVC leftMenuViewController:leftMenuVC rightMenuViewController:nil];
    sideMenu.backgroundImage = [UIImage imageNamed:@"bg_stars"];
    sideMenu.scaleBackgroundImageView = [UIImage imageNamed:@"bg_stars"];
    sideMenu.menuPreferredStatusBarStyle = 1; //
    sideMenu.contentViewShadowColor = [UIColor blackColor];
    sideMenu.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenu.contentViewShadowOpacity = 0.5;
    sideMenu.contentViewShadowEnabled = YES;
    sideMenu.contentViewShadowRadius = 10;
    sideMenu.contentViewScaleValue = 0.8;
    sideMenu.panGestureEnabled = YES;
    sideMenu.panFromEdge = YES;
    self.window.rootViewController = sideMenu;
     */
    
    [self.window makeKeyAndVisible];
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    JQLogFunction
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    JQLogFunction
}

- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    JQLogFunction
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    JQLogFunction
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    JQLogFunction

    // Save changes in the application's managed object context when the application transitions to the background.
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    
    JQLog(@"%@", URLContexts);
    
    for (UIOpenURLContext *urlContext in URLContexts) {
        
        JQBaseTabBarController *rootVC = (JQBaseTabBarController *)self.window.rootViewController;
        // 防止第一次进入不返回至主控制器
        [rootVC.viewControllers.firstObject popToRootViewControllerAnimated:YES];
        
        NSURL *url = urlContext.URL;
        if ([url.scheme isEqualToString:@"WeChat"]) {
            if ([url.host isEqualToString:@"moment"]) {
                JQLog(@"分享到微信朋友圈：%@", url.query);
            } else if ([url.host isEqualToString:@"friend"]) {
                JQLog(@"分享给微信好友：%@", url.query);
            }
        }
//        break;
        
        BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
        JQLog(@"%@", @(result));
    }
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//
//    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//    if (!result) {
//        // 其他如支付等SDK的回调
//    }
//    return result;
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    if (!result) {
//        // 其他如支付等SDK的回调
//    }
//    return result;
//}

@end
