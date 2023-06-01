//
//  JQDemoViewControllerD5.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import "JQDemoViewControllerD5.h"
#import "JQIconTextField.h"

#define kTextFieldWidth SCREEN_WIDTH - STANDARD_MARGIN * 2

@interface JQDemoViewControllerD5 () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *testTF;

@property (nonatomic, strong) JQIconTextField *usernameTF, *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation JQDemoViewControllerD5

- (JQIconTextField *)usernameTF {
    
    if (!_usernameTF) {
        _usernameTF = [[JQIconTextField alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, 100, kTextFieldWidth, 44)];
        _usernameTF.leftImageName = @"username";
        _usernameTF.placeholder = @"请输入账号";
        _usernameTF.delegate = self;
        _usernameTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _usernameTF;
}

- (JQIconTextField *)passwordTF {
    
    if (!_passwordTF) {
        CGRect frame = CGRectMake(STANDARD_MARGIN, CGRectGetMaxY(_usernameTF.frame) + STANDARD_MARGIN, kTextFieldWidth, 44);
        _passwordTF = [[JQIconTextField alloc] initWithFrame:frame leftImageName:@"password"];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditingNotification:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditingNotification:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
    /*
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, 400, SCREEN_WIDTH - STANDARD_MARGIN * 2, 40)];
    tf.text = @"我是文字";
    tf.textColor = [UIColor orangeColor];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.placeholder = @"我是占位文字";
    tf.clearsOnBeginEditing = YES;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftView.backgroundColor = [UIColor orangeColor];
    tf.leftView = leftView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    tf.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    tf.keyboardType = UIKeyboardTypeWebSearch;
    tf.returnKeyType = UIReturnKeyGo;
    tf.secureTextEntry = YES;
    
    self.testTF = tf;
    [self.view addSubview:tf];
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)loginAction:(UIButton *)sender {
    
    JQLog(@"username: %@ password: %@", self.usernameTF.text, self.passwordTF.text);
}

#pragma mark - Observer Methods

- (void)textDidBeginEditingNotification:(NSNotification *)notice {
    JQLogFunction
}

- (void)textDidEndEditingNotification:(NSNotification *)notice {
    JQLogFunction
}

- (void)textDidChangeNotification:(NSNotification *)notice {
    
    UITextField *textField = notice.object;
    JQLog(@"%@", textField.text);
    
    BOOL isEmpty = [self.usernameTF.text isEqualToString:@""] || [self.passwordTF.text isEqualToString:@""];
    self.loginBtn.enabled = !isEmpty;
}

#pragma mark - UITextFieldDelegate Methods

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
    
    return YES;
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
