//
//  JQMusicModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQMusicModel.h"

@implementation JQMusicModel

+ (NSArray *)loadMusicData {
    
    return [JQMusicModel modelArrayWithPath:@"musics"];
}

+ (NSArray *)loadNetMusicData {

    return [JQMusicModel modelArrayWithPath:@"musics2"];
}

@end
