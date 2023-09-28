//
//  JQModalDelegate.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JQCallbackDelegate <NSObject>

- (void)callbackObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END
