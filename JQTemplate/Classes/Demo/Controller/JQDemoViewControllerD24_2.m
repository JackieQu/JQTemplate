//
//  JQDemoViewControllerD24_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/13.
//

#import "JQDemoViewControllerD24_2.h"

@interface JQDemoViewControllerD24_2 ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JQDemoViewControllerD24_2

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _imageView.image = [UIImage imageNamed:@"screen01"];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.imageView];
    
//    [self imageWatermark];
    [self imageClip];
    [self imageWriteToFile];
}

- (void)imageWatermark {
    
    // layer 上下文只能显示在 drawRect 中
    
    // 位图的上下文
    // UIGraphicsBeginImageContext() 仅适用于非 retina 屏
    
    UIImage *image = [UIImage imageNamed:@"screen01"];
    
    /*
     开始位图上下文
     
     size:   位图尺寸
     opaque: 透明
     scale:  是否缩放上下文
     */
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 绘制原始图片
    //    [image drawAtPoint:CGPointZero];
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    [self watermark1];
    [self watermark2];
    [self watermark3:UIGraphicsGetCurrentContext()];
    
    // 生成一张新图片，从位图上下文获取
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    self.imageView.image = newImage;
}

- (void)watermark1 {
    
    NSString *info = @"@JackieQu";
    NSDictionary *dict = @{
                            NSForegroundColorAttributeName:[UIColor whiteColor],
                            NSFontAttributeName:[UIFont systemFontOfSize:20]
                            };
    [info drawInRect:CGRectMake(100, 150, 100, 50) withAttributes:dict];
}

- (void)watermark2 {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 50, 50)];
    [[UIColor redColor] set];
    [path fill];
}

- (void)watermark3:(CGContextRef)ref {
    
    CGContextMoveToPoint(ref, 20, 20);
    CGContextAddLineToPoint(ref, 80, 80);
    CGContextStrokePath(ref);
}

- (void)imageClip {
    
    UIImage *image = [UIImage imageNamed:@"screen01"];
    
    CGFloat newImageW = image.size.width;
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImageW, newImageW), NO, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, newImageW, newImageW)];
    // 添加截取
    [path addClip];
    // 绘图
    [image drawAtPoint:CGPointZero];
    
    // 通过上下文获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    self.imageView.image = newImage;
}

- (void)imageWriteToFile {
    
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 把涂层渲染到上下文中
    [self.view.layer renderInContext:ref];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // image 转 data
//    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    NSData *data = UIImagePNGRepresentation(newImage);
    [data writeToFile:@"/Users/JackieQu/Desktop/image.png" atomically:YES];
}

@end
