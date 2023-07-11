//
//  JQCityModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/11.
//

#import "JQCityModel.h"

@implementation JQCityModel

+ (NSArray *)loadCityData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *cityList = [NSMutableArray array];
    
    for (NSDictionary *dict in dataList) {
        JQCityModel *city = [[JQCityModel alloc] init];
        [city setValuesForKeysWithDictionary:dict];
        [cityList addObject:city];
    }
    return cityList;
}

@end
