//
//  JQAssistiveButton.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import "JQAssistiveButton.h"

@implementation JQAssistiveButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, ADAPT_VALUE(50), ADAPT_VALUE(50));
        [self setImage:[UIImage imageNamed:@"assistive_bg"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"assistive_bg"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"assistive_bg"] forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:@"assistive_bg"] forState:UIControlStateHighlighted | UIControlStateSelected];
    }
    return self;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:touch.view];
    CGPoint previousPoint = [touch previousLocationInView:touch.view];
    
    CGFloat x = currentPoint.x - previousPoint.x;
    CGFloat y = currentPoint.y - previousPoint.y;
    
    self.center = CGPointMake(self.center.x + x, self.center.y + y);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
    CGPoint finalCenterPoint = [self finalCenterPoint:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.center = finalCenterPoint;
    }];
}

- (CGPoint)finalCenterPoint:(UIView *)view {
    
    CGPoint curCenterPoint = view.center;
    
    CGFloat centerX = curCenterPoint.x;
    CGFloat centerY = curCenterPoint.y;
    
    CGFloat width = view.frame.size.width;
    CGFloat height = view.frame.size.height;
    
    CGFloat margin = ADAPT_VALUE(STANDARD_MARGIN / 4);
    CGFloat minX = margin + width / 2;
    CGFloat minY = margin + height / 2;
    CGFloat maxX = self.superview.frame.size.width - margin - width / 2;
    CGFloat maxY = self.superview.frame.size.height - margin - height / 2;
    
    CGFloat finalPointX = centerX;
    CGFloat finalPointY = centerY;
    
    if (centerY >= minY && centerY <= maxY) {
        
        finalPointX = centerX < self.superview.frame.size.width / 2 ? minX : maxX;
        
    } else {
        
        finalPointX = centerX < minX ? minX : (centerX > maxX ? maxX : centerX);
        finalPointY = centerY < minY ? minY : maxY;
    }

    return CGPointMake(finalPointX, finalPointY);
}


@end
