//
//  JQTabBarModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import "JQTabBarModel.h"
#import "JQBaseViewController.h"

static NSString *kResourceName = @"JQTabBar";

@implementation JQTabBarModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
        @"items": @"JQTabBarItemModel",
    };
}

+ (instancetype)tabBarModel {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:kResourceName ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    JQTabBarModel *tabBarModel = [JQTabBarModel modelWithDictionary:dict];
    
    NSMutableArray *availableItems = [NSMutableArray array];
    for (NSUInteger i = 0; i < tabBarModel.items.count; i ++) {
        JQTabBarItemModel *item = tabBarModel.items[i];
        // 校验是否隐藏
        if (item.isHidden) {
            continue;
        }
        // 校验类名设置
        Class cls = NSClassFromString(item.className);
        if (!(cls && [cls isSubclassOfClass:[JQBaseViewController class]])) {
            JQLog(@"%@ 第 %ld 项 className 设置错误", kResourceName, i + 1);
            cls = [JQBaseViewController class];
        }
        item.cls = cls;
        // 校验特殊 item
        if (tabBarModel.isSpecial && i == tabBarModel.specialIndex) {
            item.isSpecial = YES;
            tabBarModel.specialItem = item;
        } else {
            item.isSpecial = NO;
        }
        [availableItems addObject:item];
    }
    tabBarModel.availableItems = availableItems;
    // 校验特殊 item 下标
    if (tabBarModel.specialIndex >= availableItems.count || tabBarModel.specialIndex < 0) {
        JQLog(@"%@ specialIndex 设置错误", kResourceName);
        tabBarModel.specialIndex = availableItems.count - 1;
    }
    // 校验选中 item 下标
    if ((tabBarModel.selectedIndex >= availableItems.count || tabBarModel.selectedIndex < 0) ||
        (tabBarModel.isSpecial && tabBarModel.selectedIndex == tabBarModel.specialIndex)) {
        JQLog(@"%@ selectedIndex 设置错误", kResourceName);
        tabBarModel.selectedIndex = 0;
    }
    return tabBarModel;
}

@end

@implementation JQTabBarItemModel

@end
