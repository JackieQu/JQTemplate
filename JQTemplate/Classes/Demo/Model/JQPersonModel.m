//
//  JQPersonModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQPersonModel.h"

@implementation JQPersonModel

- (instancetype)init {
    
    if (self = [super init]) {
        
        _salutation = @"Mr";
        _firstName  = @"Jackie";
        _lastName   = @"Qu";
        _birthDate  = [NSDate date];
    }
    return self;
}

- (instancetype)initWithSalutation:(NSString *)salutation firstName:(NSString *)firstName lastName:(NSString *)lastName birthDate:(NSDate *)birthDate {
    
    if (self = [super init]) {
        
        _salutation = salutation;
        _firstName  = firstName;
        _lastName   = lastName;
        _birthDate  = birthDate;
    }
    return self;
}

@end
