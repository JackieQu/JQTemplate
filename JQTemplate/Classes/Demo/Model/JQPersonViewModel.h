//
//  JQPersonViewModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import <Foundation/Foundation.h>
#import "JQPersonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQPersonViewModel : NSObject

- (instancetype)initWithPerson:(JQPersonModel *)person;

@property (nonatomic, readonly) JQPersonModel *person;

@property (nonatomic, readonly) NSString *nameText;
@property (nonatomic, readonly) NSString *dateText;

@end

NS_ASSUME_NONNULL_END
