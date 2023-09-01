//
//  JQAudioManager.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQAudioManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface JQAudioManager ()

@property (nonatomic, strong) NSMutableDictionary *dict;

// 定时器
@property (nonatomic, strong) CADisplayLink *link;

// 播放本地音乐
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation JQAudioManager

- (NSMutableDictionary *)dict {
    
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

+ (instancetype)sharedAudioManager {
    
    static JQAudioManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (SystemSoundID)getSoundID:(NSString *)file {
    
    if ([self.dict objectForKey:file]) {
        
        return [[self.dict objectForKey:file] intValue];
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:file withExtension:nil];
    
    // 初始化 SystemSoundID 为 0，AudioServicesCreateSystemSoundID 会分配一个 SystemSoundID
    // 若 SystemSoundID 分配后还是 0，则音效添加失败
    SystemSoundID soundID = 0;
    
    // OC 对象转换为 C 变量，需要桥接
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    [self.dict setObject:@(soundID) forKey:file];
    
    return soundID;
}

- (void)playSystemSound:(NSString *)file {
    
    // 1. 获得音效
    SystemSoundID soundID = [self getSoundID:file];
    NSLog(@"%@",@(soundID));
    
    // 2. 播放音效
    AudioServicesPlaySystemSound(soundID);
}

- (void)playAlertSound:(NSString *)file {
    
    // 1. 获得音效
    SystemSoundID soundID = [self getSoundID:file];
    
    // 2. 播放音效
    AudioServicesPlaySystemSound(soundID);
    
    // 3. 添加震动（模拟器无效）
    AudioServicesPlayAlertSound(soundID);
}

- (CADisplayLink *)link {
    
    if (!_link) {
        
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(change)];
    }
    
    return _link;
}

- (void)prepareToPlayMusic:(JQMusicModel *)music {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:music.filename withExtension:nil];
    
    NSError *error = nil;
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (error) {
        NSLog(@"初始化失败：%@",error);
    } else {
        
        [_audioPlayer prepareToPlay];
        
        _audioPlayer.enableRate = YES;
    }
}

- (BOOL)play {
    
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    return [self.audioPlayer play];
}

- (void)pause {
    
    [self.audioPlayer pause];
    
    [self.link invalidate];
    
    self.link = nil;
}

- (void)stop {
    
    [self.audioPlayer stop];
    
    self.audioPlayer = nil;
    
    [self.link invalidate];
    
    self.link = nil;
}

- (void)change {
    
    // 获取当前时间，重置播放进度
    if (_currentTimeBlock) {
        _currentTimeBlock(self.audioPlayer.currentTime);
    }
}

- (BOOL)isPlaying {
    
    return [self.audioPlayer isPlaying];
}

- (NSTimeInterval)currentTime {
    
    return [self.audioPlayer currentTime];
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    
    self.audioPlayer.currentTime = currentTime;
}

- (void)setRate:(float)rate {
    
    self.audioPlayer.rate = rate;
}

- (void)setVolume:(float)volume {
    
    self.audioPlayer.volume = volume;
}

- (NSTimeInterval)duration {
    
    return self.audioPlayer.duration;
}

@end
