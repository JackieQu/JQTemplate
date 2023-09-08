//
//  JQCustomTabBar.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import <UIKit/UIKit.h>
#import "JQTabBarModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSInteger kSpecialTag = 999;

typedef NS_ENUM(NSInteger, JQCustomButtonTag) {
    JQCustomButtonDemo = 1000,
    JQCustomButtonHome,
    JQCustomButtonProfile,
};

@class JQCustomTabBar;

typedef void(^JQCustomTabBarBlock)(JQCustomTabBar *tabBar, JQCustomButtonTag tag);

@protocol JQCustomTabBarDelegate <NSObject>

- (void)tabBar:(JQCustomTabBar *)tabBar selectedAtIndex:(JQCustomButtonTag)tag;

@end

@interface JQCustomTabBar : UIView

@property (nonatomic, copy) JQCustomTabBarBlock block;

@property (nonatomic, weak) id<JQCustomTabBarDelegate> delegate;

@property (nonatomic, strong, readonly) JQTabBarModel *tabBarModel;

+ (JQCustomTabBar *)shared;

@end

NS_ASSUME_NONNULL_END
