//
//  JQShapeView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/12.
//

#import "JQShapeView.h"

@implementation JQShapeView

- (void)drawRect:(CGRect)rect {
    
    // 绘制矩形
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 50, 200)];
    
    // 绘制圆角矩形
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 50, 200) cornerRadius:100];
    
    /*
     绘制圆弧
     ArcCenter  圆弧中心
     radius     圆弧半径
     startAngle 起始角度
     endAngle   结束角度
     clockwise  顺时针
     */
    CGPoint center = CGPointMake(150, 150);

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:100 startAngle:0 endAngle:M_PI_2 clockwise:NO];

    [path addLineToPoint:center];

    // 封闭路径
    [path closePath];

    // 要使用 setFill，路径一定是封闭的
    [[UIColor yellowColor] setFill];

    [path fill];
    
    // 绘制椭圆
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 100, 200, 100)];
    
    [path stroke];
}


@end
