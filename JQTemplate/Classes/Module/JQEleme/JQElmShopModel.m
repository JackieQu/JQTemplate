//
//  JQElmShopModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import "JQElmShopModel.h"

@implementation JQElmShopModel

/**
 解决字段和本地模型属性名不一致的问题

 @return 左边是本地属性名，右边是字段名
 */
//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//
//    return @{@"desc": @"description"};
//}

/**
 解决数组中存储模型的问题

 @return 左边是网络字段，右边是模型的 Model 名
 */
//+ (NSDictionary *)mj_objectClassInArray {
//
//    return @{@"supports": @"Support"};
//}

@end
