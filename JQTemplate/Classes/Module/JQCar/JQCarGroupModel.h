//
//  JQCarGroupModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQCarGroupModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSArray *cars;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSArray *)loadCarGroupData;

@end

@interface JQCarModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@end

NS_ASSUME_NONNULL_END
