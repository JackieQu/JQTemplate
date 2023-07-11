//
//  JQCityModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/7/11.
//

#import "JQBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQCityModel : JQBaseModel

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, strong) NSArray *cities;

+ (NSArray *)loadCityData;

@end

NS_ASSUME_NONNULL_END
