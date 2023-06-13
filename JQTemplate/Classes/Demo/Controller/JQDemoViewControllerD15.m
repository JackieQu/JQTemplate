//
//  JQDemoViewControllerD15.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQDemoViewControllerD15.h"
#import "JQTextView.h"

@interface JQDemoViewControllerD15 () <UITextViewDelegate>

@end

@implementation JQDemoViewControllerD15

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 40, self.view.bounds.size.width - 40, 200)];
    textView.delegate = self;
    textView.text = @"这是文字这是文字这是文字这是文字这是文字这是文字";
    textView.font = [UIFont systemFontOfSize:20];
    textView.textColor = [UIColor redColor];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.editable = YES;
    textView.scrollEnabled = NO;
    [self.view addSubview:textView];
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 216)];
    inputView.backgroundColor = [UIColor orangeColor];
    textView.inputView = inputView;
    
    JQTextView *tv = [[JQTextView alloc] initWithFrame:CGRectMake(20, 340, self.view.bounds.size.width - 40, 200)];
    tv.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:tv];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    JQLog(@"已经开始编辑");
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    JQLog(@"已经结束编辑");
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [self.view endEditing:YES];
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    JQLog(@"%@",textView.text);
}

@end
