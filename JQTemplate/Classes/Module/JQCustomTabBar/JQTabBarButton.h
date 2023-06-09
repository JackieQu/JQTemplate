//
//  JQTabBarButton.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/8.
//

#import "JQDockButton.h"
#import "JQTabBarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQTabBarButton : JQDockButton

@property (nonatomic, strong) JQTabBarItemModel *item;

@end

NS_ASSUME_NONNULL_END
