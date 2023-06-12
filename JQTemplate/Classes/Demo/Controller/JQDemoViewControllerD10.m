//
//  JQDemoViewControllerD10.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "JQDemoViewControllerD10.h"
#import "UIBarButtonItem+Extension.h"

@interface JQDemoViewControllerD10 ()

@property (nonatomic, strong) UITextField *tf;

@end

@implementation JQDemoViewControllerD10

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" target:self action:@selector(leftClickAction)];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"更多" color:[UIColor blueColor] highlightedColor:[UIColor redColor] target:self action:@selector(rightClickAction)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImageName:@"icon_back" highlightedImageName:@"icon_back" target:self action:@selector(leftClickAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImageName:@"icon_history" highlightedImageName:@"icon_history" target:self action:@selector(rightClickAction)];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, STANDARD_MARGIN, SCREEN_WIDTH - STANDARD_MARGIN * 2, 44)];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    self.tf = tf;
    [self.view addSubview:tf];
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 216)];
    inputView.backgroundColor = [UIColor orangeColor];
    self.tf.inputView = inputView;

    UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    inputAccessoryView.backgroundColor = [UIColor blueColor];
    self.tf.inputAccessoryView = inputAccessoryView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.tf endEditing:YES];
}

- (void)leftClickAction {
    
    JQLog(@"%s",__FUNCTION__);
}

- (void)rightClickAction {
    
    JQLog(@"%s",__FUNCTION__);
}

@end
