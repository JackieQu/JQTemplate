//
//  JQDemoViewControllerD24_3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/13.
//

#import "JQDemoViewControllerD24_3.h"
#import "JQDrawView.h"

@interface JQDemoViewControllerD24_3 () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) JQDrawView *drawView;

@end

@implementation JQDemoViewControllerD24_3

- (JQDrawView *)drawView {
    
    if (!_drawView) {
        CGFloat width = SCREEN_WIDTH - STANDARD_MARGIN * 2;
        _drawView = [[JQDrawView alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, STANDARD_MARGIN, width, width * 3 / 2)];
        _drawView.backgroundColor = [UIColor lightGrayColor];
    }
    return _drawView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)initUI {
    
    [self.view addSubview:self.drawView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 40);
    btn.origin = CGPointMake(STANDARD_MARGIN, CGRectGetMaxY(self.drawView.frame) + STANDARD_MARGIN);
    [btn setTitle:@"清空" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 60, 40);
    btn2.origin = CGPointMake(CGRectGetMaxX(btn.frame) + STANDARD_MARGIN, CGRectGetMaxY(self.drawView.frame) + STANDARD_MARGIN);
    [btn2 setTitle:@"撤销" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 0, 60, 40);
    btn3.origin = CGPointMake(CGRectGetMaxX(btn2.frame) + STANDARD_MARGIN, CGRectGetMaxY(self.drawView.frame) + STANDARD_MARGIN);
    [btn3 setTitle:@"擦除" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0, 0, 60, 40);
    btn4.origin = CGPointMake(CGRectGetMaxX(btn3.frame) + STANDARD_MARGIN, CGRectGetMaxY(self.drawView.frame) + STANDARD_MARGIN);
    [btn4 setTitle:@"相册" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0, 0, 60, 40);
    btn5.origin = CGPointMake(CGRectGetMaxX(btn4.frame) + STANDARD_MARGIN, CGRectGetMaxY(self.drawView.frame) + STANDARD_MARGIN);
    [btn5 setTitle:@"保存" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.frame = CGRectMake(0, 0, 60, 40);
    btn6.origin = CGPointMake(STANDARD_MARGIN, CGRectGetMaxY(btn.frame) + STANDARD_MARGIN);
    btn6.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn6];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn7.frame = CGRectMake(0, 0, 60, 40);
    btn7.origin = CGPointMake(CGRectGetMaxX(btn6.frame) + STANDARD_MARGIN, CGRectGetMaxY(btn.frame) + STANDARD_MARGIN);
    btn7.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn7];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn8.frame = CGRectMake(0, 0, 60, 40);
    btn8.origin = CGPointMake(CGRectGetMaxX(btn7.frame) + STANDARD_MARGIN, CGRectGetMaxY(btn.frame) + STANDARD_MARGIN);
    btn8.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn8];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 140, 60)];
    slider.origin = CGPointMake(CGRectGetMaxX(btn8.frame) + STANDARD_MARGIN, CGRectGetMaxY(btn.frame) + STANDARD_MARGIN);
    [self.view addSubview:slider];
    
    [btn addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(withdraw:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(album:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [btn6 addTarget:self action:@selector(setUpColor:) forControlEvents:UIControlEventTouchUpInside];
    [btn7 addTarget:self action:@selector(setUpColor:) forControlEvents:UIControlEventTouchUpInside];
    [btn8 addTarget:self action:@selector(setUpColor:) forControlEvents:UIControlEventTouchUpInside];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)clear:(id)sender {
    
    [self.drawView clear];
}

- (void)withdraw:(id)sender {
    
    [self.drawView withdraw];
}

- (void)clean:(id)sender {
    
    self.drawView.pathColor = self.drawView.backgroundColor;
}

- (void)album:(id)sender {
    
    // 创建相册
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    // 相册: UIImagePickerControllerSourceTypePhotoLibrary
    // 相机: UIImagePickerControllerSourceTypeCamera
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 允许编辑
//    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// 相册完成选择
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 编辑图片，如果 allowsEditing 为 NO，则 image 为空
//    self.drawView.image = info[UIImagePickerControllerEditedImage];
    
    // 原始图片
    self.drawView.image = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 相册取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    JQLog(@"取消选择");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)save:(id)sender {
    
    UIGraphicsBeginImageContextWithOptions(self.drawView.frame.size, NO, 0);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    [self.drawView.layer renderInContext:ref];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // 保存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (!error) {
        JQLog(@"保存成功");
    }
}

- (void)setUpColor:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    self.drawView.pathColor = btn.backgroundColor;
}

- (void)sliderAction:(id)sender {
    
    UISlider *slider = (UISlider *)sender;
    
    self.drawView.lineWidth = slider.value * 10;
}

@end
