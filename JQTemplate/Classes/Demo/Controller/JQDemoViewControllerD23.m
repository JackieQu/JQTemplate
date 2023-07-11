//
//  JQDemoViewControllerD23.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/11.
//

#import "JQDemoViewControllerD23.h"

@interface JQDemoViewControllerD23 () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation JQDemoViewControllerD23

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        for (NSInteger i = 0; i < 10; i ++) {
            NSString *string = [NSString stringWithFormat:@"第%@行",@(i)];
            [_dataList addObject:string];
        }
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 300)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    // 选择行数
    [pickerView selectRow:1 inComponent:0 animated:YES];
    [self.view addSubview:pickerView];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.dataList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.dataList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    JQLog(@"%@",@(row));
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return component == 0 ? 150 : 100;
}

@end
