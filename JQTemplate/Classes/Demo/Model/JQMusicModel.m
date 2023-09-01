//
//  JQMusicModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQMusicModel.h"

@implementation JQMusicModel

+ (NSArray *)loadMusicData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"musics" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *musicList = [NSMutableArray array];
    for (NSDictionary *dict in dataList) {
        JQMusicModel *music = [[JQMusicModel alloc] init];
        [music setValuesForKeysWithDictionary:dict];
        [musicList addObject:music];
    }
    return musicList;
}

+ (NSArray *)loadNetMusicData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"musics2" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *musicList = [NSMutableArray array];
    for (NSDictionary *dict in dataList) {
        JQMusicModel *music = [[JQMusicModel alloc] init];
        [music setValuesForKeysWithDictionary:dict];
        [musicList addObject:music];
    }
    return musicList;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
