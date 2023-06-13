//
//  JQCarGroupModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQCarGroupModel.h"

@implementation JQCarGroupModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (NSArray *)loadCarGroupData {
    
    /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_incomplete" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *groupList = [NSMutableArray array];
    for (NSInteger i = 0; i < dataList.count; i ++) {
        NSDictionary *dict = dataList[i];
        JQCarGroupModel *group = [[JQCarGroupModel alloc] initWithDict:dict];
        [groupList addObject:group];
    }
    return groupList;
     */
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_complete" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *groupList = [NSMutableArray array];
    for (NSDictionary *groupDict in dataList) {
        JQCarGroupModel *group = [[JQCarGroupModel alloc] init];
        [group setValuesForKeysWithDictionary:groupDict];
        NSMutableArray *carList = [NSMutableArray array];
        for (NSDictionary *carDict in group.cars) {
            JQCarModel *car = [[JQCarModel alloc] init];
            [car setValuesForKeysWithDictionary:carDict];
            [carList addObject:car];
        }
        group.cars = carList;
        [groupList addObject:group];
    }
    return groupList;
}

@end

@implementation JQCarModel

@end
