//
//  JQPersonModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Person;

@protocol PersonDelegate <NSObject>

- (void)person:(Person *)person;

@end

@interface JQPersonModel : NSObject <NSCopying, NSMutableCopying, PersonDelegate>

{
    NSInteger _age;
}

//
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, readonly) NSString *salutation;
@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;
@property (nonatomic, readonly) NSDate   *birthDate;

- (instancetype)initWithSalutation:(NSString *)salutation firstName:(NSString *)firstName lastName:(NSString *)lastName birthDate:(NSDate *)birthDate;
//

- (void)method1;

- (void)method2WithName:(NSString *)name;

+ (void)classMethod;

- (void)run;

@end

NS_ASSUME_NONNULL_END
