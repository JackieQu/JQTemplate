//
//  JQMusicModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQMusicModel : JQBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, copy) NSString *singerIcon;
@property (nonatomic, copy) NSString *album;

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *songId;
//@property (nonatomic, copy) NSString *lrc;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *pic;

+ (NSArray *)loadMusicData;

+ (NSArray *)loadNetMusicData;

@end

NS_ASSUME_NONNULL_END
