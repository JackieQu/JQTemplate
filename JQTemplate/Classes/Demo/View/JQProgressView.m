//
//  JQProgressView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/12.
//

#import "JQProgressView.h"

@implementation JQProgressView

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    // drawRect 只有系统能调用
//    [self drawRect:CGRectMake(0, 0, 100, 100)];
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat radius = rect.size.width / 2 - 5;
    CGPoint center = CGPointMake(radius + 5, radius + 5);
    
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = startAngle + 2 * M_PI * _progress;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    if (endAngle < 0) {
        [[UIColor redColor] setStroke];
    } else if (endAngle < M_PI_2) {
        [[UIColor orangeColor] setStroke];
    } else if (endAngle < M_PI) {
        [[UIColor yellowColor] setStroke];
    } else {
        [[UIColor greenColor] setStroke];
    }
    
    path.lineWidth = 10;
    
    [path stroke];
}

@end
