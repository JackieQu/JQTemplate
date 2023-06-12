//
//  UIPanGestureRecognizer+Direction.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import "UIPanGestureRecognizer+Direction.h"

static CGFloat kGestureMinValue = 10.f;

@implementation UIPanGestureRecognizer (Direction)

- (UIPanGestureMoveDirection)judgeMoveDirection:(CGPoint)point {
    
    if (fabs(point.x) >= kGestureMinValue) {
        
        BOOL gestureHorizontal = NO;
        gestureHorizontal = (point.y == 0.0f) ? YES : (fabs(point.x / point.y) >= 1.0);
        if (gestureHorizontal) {
            return (point.x < 0) ? UIPanGestureMoveLeft : UIPanGestureMoveRight;
        }
        
    } else if (fabs(point.y) >= kGestureMinValue) {
        
        BOOL gestureVertical = NO;
        gestureVertical = (point.x == 0.0f) ? YES : (fabs(point.x / point.y) <= 1.0);
        if (gestureVertical) {
            return (point.y < 0) ? UIPanGestureMoveUp : UIPanGestureMoveDown;
        }
    }
    
    return UIPanGestureMoveNone;
}

@end
