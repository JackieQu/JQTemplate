//
//  JQShopModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQShopModel : NSObject

@property (nonatomic, strong) UIImage *downloadedImage;

@property (nonatomic, copy) NSString *shop_image;

@property (nonatomic, copy) NSString *shop_name;

@property (nonatomic, copy) NSString *shop_desc;

@property (nonatomic, copy) NSString *p_price;

@property (nonatomic, copy) NSString *shop_price;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *market;

+ (NSArray *)loadShopData;

@end

NS_ASSUME_NONNULL_END
