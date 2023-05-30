//
//  JQDemoViewControllerD3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQDemoViewControllerD3.h"
#import "UIImageView+GIF.h"

@interface JQDemoViewControllerD3 ()

@property (nonatomic, strong) UIImageView *testImageView;

@property (nonatomic, strong) UIImageView *gifImageView;

@end

@implementation JQDemoViewControllerD3

- (UIImageView *)testImageView {
    
    if (!_testImageView) {
        NSURL *url = [NSURL URLWithString:@"http://jackiequ.github.io/css/images/banner.jpg"];
        _testImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:data];
//        _testImageView.image = image;
        
        __weak typeof(self) weakSelf = self;
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
//                JQLog(@"Error: %@", error.localizedDescription);
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
//                JQLog(@"Invalid response");
                return;
            }

            if (data != nil) {
//                NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                JQLog(@"%@", responseStr);
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData:data];
                    weakSelf.testImageView.image = image;
                });
            }
        }];
        [task resume];
    }
    return _testImageView;
}

- (UIImageView *)gifImageView {
    
    if (!_gifImageView) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"lotus" ofType:@"gif"];
        _gifImageView = [UIImageView gifImageViewWithFrame:CGRectMake(100, 100, 200, 200) contentsOfFile:path];
    }
    return _gifImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.testImageView];
    [self.view addSubview:self.gifImageView];
    
    /*
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i <= 5; i ++) {
        NSString *str = [NSString stringWithFormat:@"lotus0%d", i];
        UIImage *image = [UIImage imageNamed:str];
        [images addObject:image];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 200, 200)];
    imageView.animationImages = images;
    imageView.animationDuration = 0.5;
    imageView.animationRepeatCount = 0;
    [self.view addSubview:imageView];
    
    [imageView startAnimating];
     */
    
    /*
    UIImage *image = [UIImage imageNamed:@"chat_bubble"];
    UIEdgeInsets insets = UIEdgeInsetsMake(50, 35, 10, 10);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, 400, SCREEN_WIDTH - STANDARD_MARGIN * 2, 100)];
    imageView.image = image;
    [self.view addSubview:imageView];
     */
    
    /*
    UIImage *image = [UIImage imageNamed:@"chat_bg"];
    UIEdgeInsets insets = UIEdgeInsetsMake(6, 6, 6, 6);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, 400, SCREEN_WIDTH - STANDARD_MARGIN * 2, 100)];
    imageView.image = image;
    [self.view addSubview:imageView];
     */
    
    /*
    UIImage *image = [UIImage imageNamed:@"chat_btn_bg"];
    UIEdgeInsets insets = UIEdgeInsetsMake(5, 2, 5, 2);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, 400, SCREEN_WIDTH - STANDARD_MARGIN * 2, 100)];
    imageView.image = image;
    [self.view addSubview:imageView];
     */
    
    /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_image" ofType:@"data"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage imageWithData:data];
    
//    NSString *localPath = @"/Users/JackieQu/Desktop/test_image.png";
//    NSData *localData = UIImagePNGRepresentation(image);
    
    NSString *localPath = @"/Users/JackieQu/Desktop/test_image.jpg";
    NSData *localData = UIImageJPEGRepresentation(image, 0.5);
    
    [localData writeToFile:localPath atomically:YES];
     */
    

    /*
//    UIImage *image = [UIImage imageNamed:@"test_image.jpg"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_image" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 400, SCREEN_WIDTH, SCREEN_WIDTH / (image.size.width / image.size.height));
    [self.view addSubview:imageView];
     */
    
    /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_image" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(100, 100, 200, 200);
    imageView.clipsToBounds = YES;
    imageView.backgroundColor = [UIColor cyanColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
     */
    
    /*
    UIImage *image = [UIImage imageNamed:@"chat_icon.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(100, 400, 100, 100);
    imageView.clipsToBounds = YES;
    
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 50;
    imageView.layer.borderWidth = 5;
    imageView.layer.borderColor = [UIColor orangeColor].CGColor;
//    imageView.layer.shadowColor = [UIColor grayColor].CGColor;
//    imageView.layer.shadowOpacity = 0.5;
//    imageView.layer.shadowOffset = CGSizeMake(10, 10);
    
    [self.view addSubview:imageView];
     */
}

@end
