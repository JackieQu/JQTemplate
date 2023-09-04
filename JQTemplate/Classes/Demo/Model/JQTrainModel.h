//
//  JQTrainModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQTrainModel : NSObject

@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *rowOrder;
@property (nonatomic, copy) NSString *hasChanges;
@property (nonatomic, copy) NSString *trainStation;
@property (nonatomic, copy) NSString *arriveTime;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *KM;

@end

NS_ASSUME_NONNULL_END
