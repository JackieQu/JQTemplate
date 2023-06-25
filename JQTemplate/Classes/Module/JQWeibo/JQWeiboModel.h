//
//  JQWeiboModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQWeiboModel : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *timer;

@property (nonatomic, copy) NSString *from;

@property (nonatomic, copy) NSArray *images;

+ (NSArray *)loadWeiboData;

@end

NS_ASSUME_NONNULL_END
