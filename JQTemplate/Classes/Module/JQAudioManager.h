//
//  JQAudioManager.h
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import <Foundation/Foundation.h>
#import "JQMusicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQAudioManager : NSObject

+ (instancetype)sharedAudioManager;

/**
 播放系统音效

 @param file 文件名
 */
- (void)playSystemSound:(NSString *)file;


/**
 播放提示音效 + 震动

 @param file 文件名
 */
- (void)playAlertSound:(NSString *)file;

/**
 播放时间回调
 */
@property (nonatomic, copy) void(^currentTimeBlock) (NSTimeInterval currentTime);

/**
 判断播放状态
 */
@property (nonatomic, getter = isPlaying, readonly) BOOL playing;

/**
 当前播放时间
 */
@property (nonatomic) NSTimeInterval currentTime;

/**
 播放音量
 */
@property (nonatomic) float volume;

/**
 播放速度
 */
@property (nonatomic) float rate;

/**
 播放总时长
 */
@property (nonatomic, readonly) NSTimeInterval duration;

/**
 准备播放音乐

 @param music music
 */
- (void)prepareToPlayMusic:(JQMusicModel *)music;

/**
 播放音乐
 */
- (BOOL)play;

/**
 暂停
 */
- (void)pause;

/**
 停止
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
