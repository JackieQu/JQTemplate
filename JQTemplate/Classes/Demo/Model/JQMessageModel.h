//
//  JQMessageModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQMessageModel : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *message;

+ (NSArray *)loadMessageData;

@end

NS_ASSUME_NONNULL_END
