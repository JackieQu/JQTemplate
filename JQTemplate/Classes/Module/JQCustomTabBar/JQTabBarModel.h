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
/// 是否有标记
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

@property (nonatomic, assign) BOOL isSpecial;
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSString *imageNormal;
@property (nonatomic, strong) NSString *imageSelected;

/// 对应 vc 类
@property (nonatomic, strong) Class cls;

@end

NS_ASSUME_NONNULL_END
