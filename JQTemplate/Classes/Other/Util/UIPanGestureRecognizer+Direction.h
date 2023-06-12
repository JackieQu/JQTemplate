//
//  UIPanGestureRecognizer+Direction.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UIPanGestureMoveDirection) {
    UIPanGestureMoveNone,
    UIPanGestureMoveUp,
    UIPanGestureMoveDown,
    UIPanGestureMoveLeft,
    UIPanGestureMoveRight,
};

@interface UIPanGestureRecognizer (Direction)

- (UIPanGestureMoveDirection)judgeMoveDirection:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
