//
//  JQDemoViewControllerD24.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/12.
//

#import "JQDemoViewControllerD24.h"
#import "JQHistogramView.h"
#import "JQPieView.h"

@interface JQDemoViewControllerD24 ()

@property (nonatomic, strong) JQHistogramView *histogramView;

@property (nonatomic, strong) JQPieView *pieView;

@end

@implementation JQDemoViewControllerD24

- (JQHistogramView *)histogramView {
    
    if (!_histogramView) {
        _histogramView = [[JQHistogramView alloc] initWithFrame:CGRectMake(20, 0, 200, 200)];
        _histogramView.backgroundColor = [UIColor whiteColor];
    }
    return _histogramView;
}

- (JQPieView *)pieView {
    
    if (!_pieView) {
        _pieView = [[JQPieView alloc] initWithFrame:CGRectMake(20, 220, 200, 200)];
        _pieView.backgroundColor = [UIColor whiteColor];
    }
    return _pieView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.histogramView];
    [self.view addSubview:self.pieView];
    
    self.histogramView.numberList = @[@300,@100,@200,@150,@300,@100,@200,@150];
    self.pieView.numberList = @[@50,@100,@150,@300,@200];
}

@end
