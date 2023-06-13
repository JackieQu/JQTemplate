//
//  JQWeChatModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQWeChatModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;

+ (NSArray *)loadWeChatData;

@end

NS_ASSUME_NONNULL_END
