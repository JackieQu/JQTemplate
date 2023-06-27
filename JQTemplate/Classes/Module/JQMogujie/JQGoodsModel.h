//
//  JQGoodsModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQGoodsModel : NSObject

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *sales;

@property (nonatomic, copy) NSString *title;

+ (NSArray *)loadGoodsData;

@end

NS_ASSUME_NONNULL_END
