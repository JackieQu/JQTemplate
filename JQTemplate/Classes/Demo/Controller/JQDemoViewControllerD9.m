//
//  JQDemoViewControllerD9.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/5.
//

#import "JQDemoViewControllerD9.h"

@interface JQDemoViewControllerD9 ()

@end

@implementation JQDemoViewControllerD9

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
//    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
//    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *rightBarItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_setting"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItems = @[rightBarItem, rightBarItem2];
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];

//    self.navigationController.navigationBarHidden = YES;
    
    NSDictionary *dict = @{
        NSFontAttributeName: [UIFont systemFontOfSize:20],
        NSForegroundColorAttributeName: [UIColor blueColor],
    };
    [self.navigationItem.rightBarButtonItems[0] setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSDictionary *titleDict = @{
        NSFontAttributeName:[UIFont systemFontOfSize:24],
        NSForegroundColorAttributeName:[UIColor redColor]
    };
    [self.navigationController.navigationBar setTitleTextAttributes:titleDict];
    
    self.navigationItem.prompt = @"这是提示";
    
    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] init];
    backBarItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backBarItem;
     */
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_history"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"icon_history"];
    btn.frame = (CGRect){CGPointZero, image.size};
    [btn setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"LEFE", @"RIGHT"]];
    self.navigationItem.titleView = segment;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"icon_back"];
    backBtn.frame = (CGRect){CGPointZero, backImage.size};
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

    // 自定义返回按钮（手势失效）
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self.navigationController popViewControllerAnimated:YES];
    
    JQBaseViewController *vc = [[JQBaseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
