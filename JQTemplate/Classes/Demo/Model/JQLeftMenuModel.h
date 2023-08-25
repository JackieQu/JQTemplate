//
//  JQLeftMenuModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQLeftMenuModel : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *vcName;

+ (NSArray *)loadLeftMenuData;

@end

NS_ASSUME_NONNULL_END
