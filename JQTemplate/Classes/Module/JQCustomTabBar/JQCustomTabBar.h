//
//  JQCustomTabBar.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import <UIKit/UIKit.h>
#import "JQTabBarModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSUInteger kSpecialTag = 1000;
static NSUInteger kStandardTag = 2000;

typedef NS_ENUM(NSUInteger, JQDockButtonType) {
    JQDockButtonDemo,
    JQDockButtonHome,
    JQDockButtonProfile,
};

@class JQCustomTabBar;

typedef void(^JQCustomTabBarBlock)(JQCustomTabBar *tabBar, JQDockButtonType type);

@protocol JQCustomTabBarDelegate <NSObject>

- (void)tabBar:(JQCustomTabBar *)tabBar selectedAtIndex:(JQDockButtonType)type;

@end

@interface JQCustomTabBar : UIView

@property (nonatomic, copy) JQCustomTabBarBlock block;

@property (nonatomic, weak) id<JQCustomTabBarDelegate> delegate;

@property (nonatomic, strong, readonly) JQTabBarModel *tabBarModel;

@end

NS_ASSUME_NONNULL_END
