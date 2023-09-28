//
//  JQHomeViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQHomeViewController.h"
#import "JQFundTableViewController.h"

@interface JQHomeViewController ()

@end

@implementation JQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = RGBA(214, 70, 41, 1);
//    [self.view addSubview:view];
//    UIView *view2 = [[UIView alloc] init];
//    view2.backgroundColor = RGBA(123, 173, 43, 1);
//    [self.view addSubview:view2];
//    UIView *view3 = [[UIView alloc] init];
//    view3.backgroundColor = RGBA(60, 143, 227, 1);
//    [self.view addSubview:view3];
//    UIView *view4 = [[UIView alloc] init];
//    view4.backgroundColor = RGBA(240, 175, 51, 1);
//    [self.view addSubview:view4];
//
//    CGFloat margin = 20;
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(margin);
//        make.left.equalTo(self.view.mas_left).with.offset(margin);
//        make.bottom.equalTo(view3.mas_top).with.offset(-margin);
//        make.right.equalTo(view2.mas_left).with.offset(-margin);
//    }];
//    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.mas_top);
//        make.left.equalTo(view.mas_right).with.offset(margin);
//        make.right.equalTo(self.view.mas_right).with.offset(-margin);
//        make.width.equalTo(view.mas_width);
//        make.height.equalTo(view.mas_height);
//    }];
//    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.mas_bottom).with.offset(margin);
//        make.left.equalTo(view.mas_left);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-margin);
//        make.width.equalTo(view.mas_width);
//        make.height.equalTo(view.mas_height);
//    }];
//    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view3.mas_top);
//        make.left.equalTo(view3.mas_right).offset(margin);
//        make.width.equalTo(view.mas_width);
//        make.height.equalTo(view.mas_height);
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [JQHUDHelper showInfoMessage:@"别点了！"];
    JQFundTableViewController *fundTableVC = [[JQFundTableViewController alloc] init];
    [self.navigationController pushViewController:fundTableVC animated:YES];
}

- (void)initUI {
    JQLogFunction;
    
//    self.view.backgroundColor = [UIColor randomColor];
}

- (void)loadData {
    JQLogFunction;
}

@end
