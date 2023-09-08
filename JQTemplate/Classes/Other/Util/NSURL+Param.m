//
//  NSURL+Param.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import "NSURL+Param.h"

@implementation NSURL (Param)

- (NSDictionary *)parameters {
    
    NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionary];
    NSArray *queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString *queryComponent in queryComponents) {
        NSString *key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString *value = [queryComponent substringFromIndex:(key.length + 1)];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}

- (NSString *)valueForParameter:(NSString *)parameterKey {
    return [[self parameters] objectForKey:parameterKey];
}

@end
