//
//  JQBaseViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQBaseViewController.h"

@interface JQBaseViewController ()

@end

@implementation JQBaseViewController

#pragma mark - Custom Methods

- (void)initUI {

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadData {
    
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)viewWillLayoutSubviews API_AVAILABLE(ios(5.0)) {
    [super viewWillLayoutSubviews];
    
}

- (void)viewDidLayoutSubviews API_AVAILABLE(ios(5.0)) {
    [super viewDidLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    JQLogFunction;
}

- (void)dealloc {
    
    JQLogFunction;
}

#pragma mark - UIResponder Methods

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
//    JQBaseViewController *vc = [[JQBaseViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];

}

- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches API_AVAILABLE(ios(9.1)) {
    [super touchesEstimatedPropertiesUpdated:touches];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
