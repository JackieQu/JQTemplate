//
//  JQCategoryModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/7/14.
//

#import "JQBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQCategoryModel : JQBaseModel

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray *subcategories;

+ (NSArray *)loadCategoryData;

@end

NS_ASSUME_NONNULL_END
