//
//  MJExtensionConfig.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import "MJExtensionConfig.h"
#import <MJExtension/MJExtension.h>
#import "JQElmShopModel.h"

@implementation MJExtensionConfig

// 程序启动一定调用
+ (void)load {
    
    /**
     解决字段和本地模型属性名不一致的问题
     
     @return 左边是本地属性名，右边是字段名
     */
    [JQElmShopModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{@"desc": @"description"};
    }];
    
    /**
     解决数组中存储模型的问题
     
     @return 左边是网络字段，右边是模型的 Model 名
     */
    [JQElmShopModel mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{@"supports": @"Support"};
    }];
}

@end
