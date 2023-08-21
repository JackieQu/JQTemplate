//
//  JQElmShopModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import <Foundation/Foundation.h>

#define kShopPageLimit 20

NS_ASSUME_NONNULL_BEGIN

@interface JQElmShopModel : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *image_path;

// - (NSString *)description {} 这个方法被系统占用
@property (nonatomic, copy) NSString *desc;

// 数组 <Activity>
@property (nonatomic, strong) NSArray *restaurant_activiy;

@property (nonatomic, strong) NSArray *supports;

@end

NS_ASSUME_NONNULL_END
