//
//  UITabBar+Badge.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (Badge)

- (void)showBadgeAtIndex:(int)index;

- (void)hideBedgeAtIndex:(int)index;

@end

NS_ASSUME_NONNULL_END
