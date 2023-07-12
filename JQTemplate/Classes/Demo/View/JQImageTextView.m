//
//  JQImageTextView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/12.
//

#import "JQImageTextView.h"

@implementation JQImageTextView

- (void)drawRect:(CGRect)rect {

    /*
    // 图片，超出部分全部裁剪
    UIRectClip(CGRectMake(100, 100, 100, 100));
    
    UIImage *image = [UIImage imageNamed:@"screen01"];

    // 根据 rect 拉伸图片
//    [image drawInRect:CGRectMake(0, 0, 200, 200)];

    // 显示原图片尺寸
    [image drawAtPoint:CGPointZero];
    
    // 平铺绘图
//    [image drawAsPatternInRect:rect];
     */
    
    NSString *string = @"abcdefghijklmnopqrstuvwxyz";
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor yellowColor];
    shadow.shadowOffset = CGSizeMake(2, 2);
    // 模糊度
    shadow.shadowBlurRadius = 2;
    
    NSDictionary *dict = @{
        NSFontAttributeName:[UIFont systemFontOfSize:30],
        NSForegroundColorAttributeName:[UIColor redColor],
        NSStrokeColorAttributeName:[UIColor blueColor],
        NSStrokeWidthAttributeName:@(2),
        NSShadowAttributeName:shadow
    };
    
    [string drawInRect:rect withAttributes:dict];
    
    // 不换行
//    [string drawAtPoint:CGPointZero withAttributes:nil];
}

@end
