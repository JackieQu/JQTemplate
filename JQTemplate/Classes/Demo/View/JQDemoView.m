//
//  JQDemoView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import "JQDemoView.h"

@implementation JQDemoView

{
    CGPoint _touchPoint;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JQLogFunction
    
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:touch.view];
    
    JQLog(@"touch.window: %@", touch.window);
    JQLog(@"touch.view: %@", touch.view);
    
    _touchPoint = self.center;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JQLogFunction
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:touch.view];
    JQLog(@"currentPoint: %@", NSStringFromCGPoint(currentPoint));
    
    CGPoint previousPoint = [touch previousLocationInView:touch.view];
    JQLog(@"previousPoint: %@", NSStringFromCGPoint(previousPoint));

    CGFloat x = currentPoint.x - previousPoint.x;
    CGFloat y = currentPoint.y - previousPoint.y;
    
    CGFloat centerX = (self.center.x + x) >= 20 ? self.center.x + x : 20;
    CGFloat centerY = (self.center.y + y) >= 20 ? self.center.y + y : 20;

    self.center = CGPointMake(centerX, centerY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JQLogFunction
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = self->_touchPoint;
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JQLogFunction
}

@end
