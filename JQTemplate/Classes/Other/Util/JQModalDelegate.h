//
//  JQModalDelegate.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JQModalDelegate <NSObject>

- (void)passObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END
