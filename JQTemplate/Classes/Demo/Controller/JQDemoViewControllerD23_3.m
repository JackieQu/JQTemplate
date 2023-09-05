//
//  JQDemoViewControllerD23_3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/12.
//

#import "JQDemoViewControllerD23_3.h"
#import "JQProgressView.h"
#import "JQLineView.h"
#import "JQShapeView.h"
#import "JQImageTextView.h"

@interface JQDemoViewControllerD23_3 ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) JQProgressView *progressView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UISlider *slider;

@end

@implementation JQDemoViewControllerD23_3

- (JQProgressView *)progressView {
    
    if (!_progressView) {
        _progressView = [[JQProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _progressView.center = CGPointMake(self.view.centerX, 300);
        _progressView.backgroundColor = [UIColor lightGrayColor];
    }
    return _progressView;
}

- (UILabel *)label {
    
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _label.center = self.progressView.center;
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (UISlider *)slider {
    
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        _slider.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.progressView.frame) + STANDARD_MARGIN);
        [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UITextField *)textField {
    
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        _textField.center = CGPointMake(self.view.centerX, 700);
//        _textField.delegate = self;
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    JQLineView *lineView = [[JQLineView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];
    
    JQShapeView *shapeView = [[JQShapeView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    shapeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shapeView];
    
    JQImageTextView *imageTextView = [[JQImageTextView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    imageTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageTextView];
    
//    [self.view addSubview:self.progressView];
//    [self.view addSubview:self.label];
//    [self.view addSubview:self.slider];
    
    [self.view addSubview:self.textField];
    
    // 默认显示当前时间
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.height += TAB_BAR_HEIGHT;
    
    // 获取所有时区
//    JQLog(@"%@",[NSLocale availableLocaleIdentifiers]);
    
    // 设置时区
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    
    // datePicker 样式
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:@"2018-10-31 13:20:30"];
    datePicker.date = date;
    
    // 设置最小/最大时间
//    NSInteger i = 60 * 60 * 24 * 7;
//    datePicker.minimumDate = [date dateByAddingTimeInterval:-i];
//    datePicker.maximumDate = [date dateByAddingTimeInterval:i];
    
    // 设置时间间隔
    datePicker.minuteInterval = 30;
    
    [datePicker addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventValueChanged];
    
    self.textField.inputView = datePicker;
}

- (void)doAction:(UIDatePicker *)picker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy 年 MM 月 dd 日 HH 时 mm 分 ss 秒";
    NSString *string = [formatter stringFromDate:picker.date];
    self.textField.text = string;
}

- (void)sliderAction:(UISlider *)sender {
    
    self.label.text = [NSString stringWithFormat:@"%d%%",(int)(sender.value * 100)];
    self.progressView.progress = sender.value;
}

@end
