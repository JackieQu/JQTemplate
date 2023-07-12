//
//  JQDemoViewControllerD23_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/11.
//

#import "JQDemoViewControllerD23_2.h"
#import "JQCityModel.h"

@interface JQDemoViewControllerD23_2 () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation JQDemoViewControllerD23_2

- (UITextField *)textField {
    
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        _textField.center = CGPointMake(self.view.centerX, 200);
        _textField.delegate = self;
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _textField;
}

- (UIPickerView *)pickerView {
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = [JQCityModel loadCityData];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.textField];
    self.textField.inputView = self.pickerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
    [self.pickerView selectRow:1 inComponent:1 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.dataList.count;
    }
    
    // 返回选中的 row
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    
    JQCityModel *city = self.dataList[selectedRow];
    
    return city.cities.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [self.dataList[row] provinceName];
    }
    
    // 返回选中的 row
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    
    JQCityModel *city = self.dataList[selectedRow];
    
    if (city.cities.count > row) {
        return city.cities[row];
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
//    [pickerView reloadAllComponents];
    
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    
    JQCityModel *city = self.dataList[selectedRow];
    
    NSInteger index = [pickerView selectedRowInComponent:1];
    
    index = (index > city.cities.count - 1) ? city.cities.count - 1 : index;
    
    NSString *cityName = city.cities[index];
    
    self.textField.text = [NSString stringWithFormat:@"%@%@",city.provinceName,cityName];
    
    [pickerView reloadComponent:1];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    NSInteger selectedRow = [self.pickerView selectedRowInComponent:0];
    
    JQCityModel *city = self.dataList[selectedRow];
    
    NSInteger index = [self.pickerView selectedRowInComponent:1];
    
//    index = (index > city.cities.count - 1) ? city.cities.count - 1 : index;
    
    NSString *cityName = city.cities[index];
    
    self.textField.text = [NSString stringWithFormat:@"%@%@",city.provinceName,cityName];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

@end
