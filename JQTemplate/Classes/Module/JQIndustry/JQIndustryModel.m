//
//  JQIndustryModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQIndustryModel.h"

@implementation JQIndustryModel

+ (NSArray *)loadIndustryData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"industries" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *industryList = [NSMutableArray array];
    for (NSDictionary *dict in dataList) {
        JQIndustryModel *industry = [[JQIndustryModel alloc] init];
        [industry setValuesForKeysWithDictionary:dict];
        [industryList addObject:industry];
    }
    return industryList;
}

@end
