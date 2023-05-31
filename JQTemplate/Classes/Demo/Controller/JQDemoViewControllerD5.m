//
//  JQDemoViewControllerD5.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import "JQDemoViewControllerD5.h"
#import "JQLoginTextField.h"

#define kTextFieldWidth SCREEN_WIDTH - STANDARD_MARGIN * 2

@interface JQDemoViewControllerD5 () <UITextFieldDelegate>

@property (nonatomic, strong) JQLoginTextField *usernameTF, *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation JQDemoViewControllerD5

- (JQLoginTextField *)usernameTF {
    
    if (!_usernameTF) {
        _usernameTF = [[JQLoginTextField alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, 100, kTextFieldWidth, 44)];
        _usernameTF.leftImageName = @"username";
        _usernameTF.placeholder = @"请输入账号";
        _usernameTF.delegate = self;
        _usernameTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _usernameTF;
}

- (JQLoginTextField *)passwordTF {
    
    if (!_passwordTF) {
        CGRect frame = CGRectMake(STANDARD_MARGIN, CGRectGetMaxY(_usernameTF.frame) + STANDARD_MARGIN, kTextFieldWidth, 44);
        _passwordTF = [[JQLoginTextField alloc] initWithFrame:frame leftImageName:@"password"];
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.delegate = self;
        _passwordTF.secureTextEntry = YES;
    }
    return _passwordTF;
}

- (UIButton *)loginBtn {
    
    if (!_loginBtn) {
        CGFloat pointY = CGRectGetMaxY(_passwordTF.frame) + STANDARD_MARGIN;
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(STANDARD_MARGIN, pointY, kTextFieldWidth, 44);
        _loginBtn.enabled = NO;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 4.4f;
        
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f8f3"];
    [self.view addSubview:self.usernameTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)loginAction:(UIButton *)sender {
    
    JQLog(@"username: %@ password: %@", self.usernameTF.text, self.passwordTF.text);
}

- (void)loginTextDidChangeNotification:(NSNotification *)notice {
    
    BOOL isEmpty = [self.usernameTF.text isEqualToString:@""] || [self.passwordTF.text isEqualToString:@""];
    self.loginBtn.enabled = !isEmpty;
}

- (void)textDidBeginEditingNotification:(NSNotification *)notice {
    JQLogFunction
}

- (void)textDidEndEditingNotification:(NSNotification *)notice {
    JQLogFunction
}

- (void)textDidChangeNotification:(NSNotification *)notice {
    
    UITextField * textField = notice.object;
    JQLog(@"%@", textField.text);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    JQLogFunction
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    JQLogFunction
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    JQLogFunction
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    JQLogFunction
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    JQLogFunction
    
    JQLog(@"%@", NSStringFromRange(range));
    JQLog(@"%@",string);

    return range.location > 10 ? NO : YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    JQLogFunction
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    JQLogFunction
    
    if (textField == self.usernameTF) {
        [self.passwordTF becomeFirstResponder];
    } else if (textField == self.passwordTF) {
        [self.passwordTF resignFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
    return YES;
}

@end
