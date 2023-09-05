//
//  JQDemoViewControllerD33_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/18.
//

#import "JQDemoViewControllerD33_2.h"
#import "JQHTTPManager.h"
#import "UIImageView+SDWebImage.h"

@interface JQDemoViewControllerD33_2 ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JQDemoViewControllerD33_2

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
        _imageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.imageView];
    [self testLoadImage];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self testLoadData];
}

- (void)testLoadData {
    
    [[JQHTTPManager shared] requestWithPath:@"http://127.0.0.1/city.json" method:JQHTTPRequestGet parameters:@{} prepare:^{

        JQLog(@"显示指示器");

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

        JQLog(@"%@",responseObject);
        JQLog(@"关闭指示器");

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {

        JQLog(@"failure - %@",error);
        JQLog(@"关闭指示器");
    }];
}

- (void)testLoadImage {
    
    // http://127.0.0.1/images/lotus.gif
    [self.imageView downloadImage:@"https://jackiequ.github.io/css/images/banner.jpg" placeholderImage:[UIImage imageNamed:@"scene"] progress:^(CGFloat progress) {
        
        JQLog(@"progress - %.2f%%",progress);
    } success:^(SDImageCacheType cacheType, UIImage *image) {
        
        JQLog(@"success - %@",@(cacheType));
        
    } failure:^(NSError *error) {
        
        JQLog(@"failure - %@",error);
        
    }];
}
@end
