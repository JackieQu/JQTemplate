//
//  JQDemoViewControllerD6.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/1.
//

#import "JQDemoViewControllerD6.h"
#import "JQBlockButton.h"

@interface JQDemoViewControllerD6 ()

@end

@implementation JQDemoViewControllerD6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 40);
    [btn setTitle:@"UIAlertController" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 180, 200, 40);
    [btn2 setTitle:@"UIActivityIndicatorView" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(showIndicator) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 260, 0, 0)];
    mySwitch.centerX = self.view.centerX;
    mySwitch.tintColor = [UIColor blueColor];
    mySwitch.onTintColor = [UIColor blueColor];
    mySwitch.thumbTintColor = [UIColor orangeColor];
    mySwitch.on = YES;
    [mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch];
    
    NSArray *items = @[@"RED", @"GREEN", @"YELLOW"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    segment.frame = CGRectMake(STANDARD_MARGIN, 340, CGRectGetWidth(self.view.frame) - STANDARD_MARGIN * 2, 40);
    segment.tintColor = [UIColor blueColor];
    segment.momentary = NO;
    segment.apportionsSegmentWidthsByContent = NO;
//    [segment insertSegmentWithTitle:@"ITEM" atIndex:1 animated:YES];
//    [segment setImage:[UIImage imageNamed:@""] forSegmentAtIndex:2];
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(100, 420, 200, 40)];
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.value = 20;
//    slider.minimumValueImage = [UIImage imageNamed:@""];
//    slider.maximumValueImage = [UIImage imageNamed:@""];
    slider.continuous = YES;
    slider.minimumTrackTintColor = [UIColor redColor];
    slider.maximumTrackTintColor = [UIColor greenColor];
    slider.thumbTintColor = [UIColor orangeColor];
//    [slider setThumbImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [slider setMinimumTrackImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [slider setMaximumTrackImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(0, 500, 0, 0)];
    stepper.centerX = self.view.centerX;
    stepper.tintColor = [UIColor blueColor];
    stepper.continuous = YES;
    stepper.autorepeat = YES;
    stepper.wraps = YES;
    stepper.value = 20;
    stepper.minimumValue = 0;
    stepper.maximumValue = 100;
    [stepper addTarget:self action:@selector(stepperAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper];
}

- (void)showAlert {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        JQLog(@"cancel");
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Action" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        JQLog(@"action");
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:action];
//    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.secureTextEntry = YES;
//    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)showIndicator {
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    indicator.center = self.view.center;
    indicator.color = [UIColor orangeColor];
    indicator.hidesWhenStopped = NO;
    [self.view addSubview:indicator];
    
    [indicator startAnimating];
    
    [self performSelector:@selector(dismissIndicator:) withObject:indicator afterDelay:5];
}

- (void)dismissIndicator:(UIActivityIndicatorView *)sender {
    
    [sender stopAnimating];
    [sender removeFromSuperview];
}

- (void)switchAction:(UISwitch *)sender {
    
    sender.thumbTintColor = sender.on ? [UIColor redColor] : [UIColor orangeColor];
}

- (void)segmentAction:(UISegmentedControl *)sender {
    
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            sender.backgroundColor = [UIColor redColor];
            break;
        case 1:
            sender.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            sender.backgroundColor = [UIColor yellowColor];
            break;
        default:
            sender.backgroundColor = [UIColor whiteColor];
            break;
    }
}

- (void)sliderAction:(UISlider *)sender {
    
    JQLog(@"%.2f", sender.value);
}

- (void)stepperAction:(UIStepper *)sender {
    
    JQLog(@"%.2f", sender.value);
}

@end
