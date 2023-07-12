//
//  JQHistogramView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/12.
//

#import "JQHistogramView.h"

@implementation JQHistogramView

- (void)setNumberList:(NSArray *)numberList {
    
    NSInteger total = 0;
    
    for (NSInteger i = 0; i < numberList.count; i ++) {
        
        total += [numberList[i] integerValue];
    }
    
    NSMutableArray * percentageList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < numberList.count; i ++) {
        
        [percentageList addObject:@([numberList[i] doubleValue] * 100 / total)];
    }
    
    _numberList = percentageList;
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 0;
    CGFloat h = 0;
    
    for (NSInteger i = 0; i < self.numberList.count; i ++) {
        
        // 宽度 = 总宽度 / (数据数 * 2 - 1)
        w = rect.size.width / (self.numberList.count * 2 - 1);
        // 每两列加一个柱形
        x = w * i * 2;
        // 高度根据百分比计算
        h = [self.numberList[i] doubleValue] / 100 * rect.size.height;
        y = rect.size.height - h;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        [[UIColor randomColor] set];
        
        [path fill];
    }
}


@end
