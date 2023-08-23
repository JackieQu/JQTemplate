//
//  JQDemoViewControllerD35_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/23.
//

#import "JQDemoViewControllerD35_2.h"
#import <Masonry/Masonry.h>

@interface JQDemoViewControllerD35_2 ()

@end

@implementation JQDemoViewControllerD35_2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *superView = self.view;
    
    UIButton *blueView = [UIButton buttonWithType:UIButtonTypeCustom];
    blueView.backgroundColor = [UIColor blueColor];
    [superView addSubview:blueView];
    
    UIButton *yellowView = [UIButton buttonWithType:UIButtonTypeCustom];
    yellowView.backgroundColor = [UIColor yellowColor];
    [superView addSubview:yellowView];
    
    [blueView addTarget:self action:@selector(jumpToMomentVC) forControlEvents:UIControlEventTouchUpInside];
    [yellowView addTarget:self action:@selector(jumpToFriendVC) forControlEvents:UIControlEventTouchUpInside];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(superView.mas_left).with.offset(20);
        make.bottom.equalTo(superView.mas_bottom).with.offset(-20);
        make.right.equalTo(yellowView.mas_left).with.offset(-20);
        make.height.equalTo(@30);
    }];

    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(blueView.mas_right).with.offset(20);
        make.bottom.equalTo(blueView.mas_bottom);
        make.right.equalTo(superView.mas_right).with.offset(-20);
        make.width.equalTo(blueView.mas_width);
        make.height.equalTo(blueView.mas_height);
    }];
    
    // 填满屏幕
    /*
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        // 链式语法
        
        // 1.
//        make.top.equalTo(superView.mas_top);
//        make.left.equalTo(superView.mas_left);
//        make.bottom.equalTo(superView.mas_bottom);
//        make.right.equalTo(superView.mas_right);
        
        // 2.
//        make.top.equalTo(superView);
//        make.left.equalTo(superView);
//        make.bottom.equalTo(superView);
//        make.right.equalTo(superView);
        
        // 3.
//        make.top.and.left.and.bottom.and.right.equalTo(superView);
        
        // 4.
//        make.top.left.bottom.right.equalTo(superView);
        
        // 5. edges 边距
        make.edges.equalTo(superView);
    }];
     */
    
    // 填充屏幕并带有间距
    /*
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        // offset(10) 设置间距
        // top、left 设置间距用正数
        // bottom、right 设置间距用负数
        
        // 1.
//        make.top.equalTo(superView.mas_top).with.offset(20);
//        make.left.equalTo(superView.mas_left).with.offset(20);
//        make.bottom.equalTo(superView.mas_bottom).with.offset(-20);
//        make.right.equalTo(superView.mas_right).with.offset(-20);
        
        // 2.
//        UIEdgeInsets padding = UIEdgeInsetsMake(20, 20, 20, 20);
//        [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.bottom.right.equalTo(superView).with.insets(padding);
//        }];
        
        // 3.
//        UIEdgeInsets padding = UIEdgeInsetsMake(20, 20, 20, 20);
//        make.edges.equalTo(superView).with.insets(padding);
        
        // 4.
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.bottom.equalTo(@-20);
        make.right.equalTo(@-20);
    }];
     */
    
    // 居中
    /*
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
       
//        make.size.equalTo(CGSizeMake(100, 100));
        
        make.center.mas_equalTo(CGPointMake(0, 0));
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
     */
    
    // 左上
    /*
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
       
//        make.top.equalTo(superView.mas_top);
//        make.left.equalTo(superView.mas_left);
//        make.width.equalTo(@100);
//        make.height.equalTo(@100);
        
        make.top.left.equalTo(superView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
     */
}

- (void)jumpToMomentVC {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"WeChat://"]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"WeChat://moment?from=DingTalk"] options:[NSDictionary dictionary] completionHandler:^(BOOL success) {
            NSLog(@"分享到微信朋友圈");
        }];
    }
}

- (void)jumpToFriendVC {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"WeChat://"]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"WeChat://friend?from=DingTalk"] options:[NSDictionary dictionary] completionHandler:^(BOOL success) {
            NSLog(@"分享给微信好友");
        }];
    }
}

@end
