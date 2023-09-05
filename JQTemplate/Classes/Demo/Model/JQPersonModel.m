//
//  JQPersonModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQPersonModel.h"

@interface JQPersonModel ()

{
    NSString *_number;
}

@property (nonatomic, assign) CGFloat height;

- (void)classMethod:(NSString *)name age:(NSInteger)age;

@end

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

- (void)method1 {
    
}

- (void)method2WithName:(NSString *)name {
    
}

+ (void)classMethod {
    
}

- (void)classMethod:(NSString *)name age:(NSInteger)age {
    
}

- (void)run {
    
    JQLog(@"%s",__FUNCTION__);
}

@end
