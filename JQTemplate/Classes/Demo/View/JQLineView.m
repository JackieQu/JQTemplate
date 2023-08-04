//
//  JQLineView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/12.
//

#import "JQLineView.h"

@implementation JQLineView

/*
 绘图代码写在 drawRect 中，view 加载完成，需要显示的时候调用
 
 1. 获取图形上下文
 2. 创建路径
 3. 把图形放入上下文
 4. 渲染上下文
 */
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ref, 50, 50);
    
    /*
     画曲线
     arg1 上下文
     arg2、arg3 控制点 x、y
     arg4、arg5 终点 x、y
     */
    CGContextAddQuadCurveToPoint(ref, 100, 100, 300, 50);
    
    CGContextStrokePath(ref);
    
//    [self drawBezierLine];
    [self drawLine1];
    [self drawLine2];
    [self drawLine3];
    
    NSLog(@"%@",NSStringFromCGRect(rect));
}

- (void)drawBezierLine {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    
    [path addLineToPoint:CGPointMake(200, 200)];
    [path addLineToPoint:CGPointMake(100, 10)];
    
    path.lineWidth = 10;
    
    // set = setStroke + setFill (描边 + 填充)
    [[UIColor redColor] set];
    
    [path stroke];
    
//    UIBezierPath *path2 = [UIBezierPath bezierPath];
//
//    [path2 moveToPoint:CGPointMake(100, 200)];
//
//    [path2 addLineToPoint:CGPointMake(60, 80)];
//    [path2 addLineToPoint:CGPointMake(100, 10)];
//
//    path2.lineWidth = 10;
//
//    [[UIColor blueColor] set];
//
//    [path2 stroke];
}

// 方法一，最原始的方法
- (void)drawLine1 {
    
    // 1. 获取图形上下文，CG，CoreGraphics 有关图形的框架，mac 开发也适用
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 2. 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 2.1 设置起始点
    CGPathMoveToPoint(path, NULL, 50, 50);
    
    // 2.2 画线到某点
    CGPathAddLineToPoint(path, NULL, 200, 200);
    
    // 3. 把图形放入上下文
    CGContextAddPath(ref, path);
    
    // 4. 渲染上下文
    CGContextStrokePath(ref);
}

// 方法二
- (void)drawLine2 {
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 设置起始点
    CGContextMoveToPoint(ref, 50, 100);
    
    // 画线并设置终点
    CGContextAddLineToPoint(ref, 200, 200);
    
    // 默认下一根线的起点为上一条线的终点
    CGContextAddLineToPoint(ref, 150, 300);
    
    // 设置线的宽度
    CGContextSetLineWidth(ref, 5);
    
    // 设置连接样式
    CGContextSetLineJoin(ref, kCGLineJoinRound);
    
    // 设置顶角样式
    CGContextSetLineCap(ref, kCGLineCapRound);
    
    // 设置线的颜色
    [[UIColor whiteColor] setStroke];
    
    // 渲染上下文
    CGContextStrokePath(ref);
}

// 方法三
- (void)drawLine3 {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 150)];
    
    [path addLineToPoint:CGPointMake(200, 200)];
    
    [path stroke];
}

@end
