//
//  JQIndustryModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQIndustryModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *state;

+ (NSArray *)loadIndustryData;

@end

NS_ASSUME_NONNULL_END
