//
//  JQDemoViewControllerD39.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/25.
//

#import "JQDemoViewControllerD39.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>

@interface JQDemoViewControllerD39 ()

@end

@implementation JQDemoViewControllerD39

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavItem];
    [self setupGesture];
}

- (void)setupNavItem {

    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(leftDrawerButtonPress)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightDrawerButtonPress)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)leftDrawerButtonPress {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)rightDrawerButtonPress {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)setupGesture {
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
}

- (void)doubleTap:(UITapGestureRecognizer *)gesture {
    
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

@end
