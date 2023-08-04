//
//  JQPieView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/12.
//

#import "JQPieView.h"

@implementation JQPieView

- (void)setNumberList:(NSArray *)numberList {
    
    NSInteger total = 0;
    
    for (NSInteger i = 0; i < numberList.count; i ++) {
        
        total += [numberList[i] integerValue];
    }
    
    NSMutableArray *percentageList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < numberList.count; i ++) {
        
        [percentageList addObject:@([numberList[i] doubleValue] * 100 / total)];
    }
    
    _numberList = percentageList;
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat radius = rect.size.width / 2;
    CGPoint center = CGPointMake(radius, radius);
    
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    
    // 旋转的角度
    CGFloat angle = 0;
    
    for (NSInteger i = 0; i < self.numberList.count; i ++) {
        
        // 上一个结束点即为下一个起始点
        startAngle = endAngle;
        // 角度根据百分比计算
        angle = [self.numberList[i] doubleValue] / 100 * 2 * M_PI;
        // 结束角度 = 起始角度 + 旋转角度
        endAngle = startAngle + angle;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        [path addLineToPoint:center];
        
        [[UIColor randomColor] set];
        
        [path fill];
    }
}

@end
