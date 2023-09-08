//
//  JQTabBarModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "JQBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class JQTabBarItemModel;

@interface JQTabBarModel : JQBaseModel

/// 是否有动画
@property (nonatomic, assign) BOOL isAnimated;
/// 是否有标线
@property (nonatomic, assign) BOOL isMarked;
/// 是否有特殊项
@property (nonatomic, assign) BOOL isSpecial;
/// 特殊 item 下标
@property (nonatomic, assign) NSInteger specialIndex;
/// 选中 item 下标
@property (nonatomic, assign) NSInteger selectedIndex;
/// item 列表
@property (nonatomic, strong) NSArray<JQTabBarItemModel *> *items;

/// 可用 item 列表
@property (nonatomic, strong) NSMutableArray<JQTabBarItemModel *> *availableItems;
/// 特殊 item
@property (nonatomic, strong) JQTabBarItemModel *specialItem;

+ (instancetype)tabBarModel;

@end

@interface JQTabBarItemModel : JQBaseModel

/// 标题
@property (nonatomic, strong) NSString *title;
/// 类名
@property (nonatomic, strong) NSString *className;
/// 图标 normal
@property (nonatomic, strong) NSString *imageNormal;
/// 图标 selected
@property (nonatomic, strong) NSString *imageSelected;
/// 是否隐藏
@property (nonatomic, assign) BOOL isHidden;

/// 是否特殊
@property (nonatomic, assign) BOOL isSpecial;
/// 对应的类
@property (nonatomic, strong) Class cls;

@end

NS_ASSUME_NONNULL_END
