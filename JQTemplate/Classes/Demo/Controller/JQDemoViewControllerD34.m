//
//  JQDemoViewControllerD34.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

/*
 UIWebView 是苹果提供用于展示网页的 UI 控件，也是最占内存的控件
 
 iOS8.0 的 WKWebKit 框架相比 UIWebView 节省了 1/3 ～ 1/4 的内存，速度快，但没有缓存功能
 
 iOS开发 Xcode Native 原生开发 + HMLT -> 混合开发
 
 iOS 和 HTML 的混合，需要 OC 与 JS 交互
 
 OC 调用 JS 代码，stringByEvaluatingJavaScriptFromString
 JS 调用 OC 代码，苹果没提供，需要通过代理完成
 */

/*
 PhoneGap 专门做混合开发，现已被 Adobe 收购
 
 WebViewJavascriptBridge 国内用的比较多
 
 混合开发的优点：跨平台，快速迭代，时间、人员成本相对较低
 混合开发的缺点：流畅度差，无法做到深度开发，更消耗流量，若大部分为 HTML 界面，核审容易被拒
 
 JS 和 OC 通信：
 运用 webView 提供的代理，根据网页回传 url，进行解析，获取数据
 */

#import "JQDemoViewControllerD34.h"
#import "NSURL+Param.h"

@interface JQDemoViewControllerD34 () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *forwardItem;
@property (nonatomic, strong) UIBarButtonItem *refreshItem;

@end

@implementation JQDemoViewControllerD34

- (UIWebView *)webView {
    
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor lightGrayColor];
        _webView.delegate = self;
        // 设置边距
        _webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        // 若网页不是响应式布局，需要调用这个方法
        _webView.scalesPageToFit = YES;
        // 是否响应电话等信息
        _webView.dataDetectorTypes = UIDataDetectorTypeNone;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@">" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(goBack)];
    self.backItem = item;
    self.forwardItem = item2;
    self.refreshItem = item3;
    self.navigationItem.rightBarButtonItems = @[item3, item2, item];
    
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    // 加载本地网页
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    // 加载本地网页 2
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
//    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)goBack {
    
    [self.webView goBack];
}

- (void)goForward {
    
    [self.webView goForward];
}

- (void)refresh {
    
    [self.webView reload];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    JQLog(@"%@",request.URL);
    NSURL * url = request.URL;
//    JQLog(@"%@",url.scheme);
//    JQLog(@"%@",url.host);
//    JQLog(@"%@",url.query);
    
//    if ([url.absoluteString hasPrefix:@"test"]) {
//
//        JQLog(@"%@",url.absoluteString);
//    }
    
    if ([url.scheme isEqualToString:@"http"]) {
        
        if ([url.host isEqualToString:@"127.0.0.1"]) {

            NSString *username = [url valueForParameter:@"username"];
            NSString *password = [url valueForParameter:@"password"];

            return [self loginWithUsername:username password:password];
        }
    }

    if ([url.scheme isEqualToString:@"test"]) {
        
        if ([url.host isEqualToString:@"clickTest"]) {
            
            NSString *methodString = [NSString stringWithFormat:@"%@:",url.host];
            
            [self performSelector:NSSelectorFromString(methodString) withObject:url.query afterDelay:0];
        }
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    JQLog(@"开始加载");
    
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JQLog(@"结束加载");
    
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
    
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    JQLog(@"%@",error);
}

- (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password {
    
    BOOL pass = [username isEqualToString:@"JackieQu"] && [password isEqualToString:@"123456"];
    
    NSString *msg = pass ? @"登录成功" : @"登录失败";
    
    NSString *jsCode = [NSString stringWithFormat:@"alert('%@');",msg];
    
    // OC 调用 JS 代码
    [self.webView stringByEvaluatingJavaScriptFromString:jsCode];
    
    return pass;
}

- (void)clickTest:(NSString *)params {
    
    JQLog(@"我是 OC 代码");
    
    JQLog(@"%@", [self paramsDict:params]);
}

- (NSDictionary *)paramsDict:(NSString *)paramsString {
    
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    
    if (!paramsString || [paramsString isEqualToString:@""]) {
        return paramsDict;
    }
    
    NSArray *components = [paramsString componentsSeparatedByString:@"&"];
    
    for (NSString *component in components) {
        
        NSString *key = [component componentsSeparatedByString:@"="].firstObject;
        NSString *value = [component substringFromIndex:(key.length + 1)];
        [paramsDict setObject:value forKey:key];
    }
    return paramsDict;
}

@end
