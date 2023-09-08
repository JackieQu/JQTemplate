//
//  UITabBar+Badge.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (Badge)

- (void)showBadgeAtIndex:(NSInteger)index;

- (void)hideBedgeAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
