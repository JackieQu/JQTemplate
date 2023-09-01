//
//  JQPersonViewModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQPersonViewModel.h"

@implementation JQPersonViewModel

- (instancetype)initWithPerson:(JQPersonModel *)person {
    
    if (self = [super init]) {
        
        _person = person;
        
        if (person.salutation.length > 0) {
            _nameText = [NSString stringWithFormat:@"%@ %@ %@",self.person.salutation,self.person.firstName,self.person.lastName];
        } else {
            _nameText = [NSString stringWithFormat:@"%@ %@",self.person.firstName,self.person.lastName];
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEEE MMMM d, yyyy"];
        _dateText = [formatter stringFromDate:person.birthDate];
    }
    
    return self;
}

@end
