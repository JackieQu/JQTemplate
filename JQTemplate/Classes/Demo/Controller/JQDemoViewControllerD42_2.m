//
//  JQDemoViewControllerD42_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQDemoViewControllerD42_2.h"
#import <AVFoundation/AVFoundation.h>
#import "JQAudioManager.h"

#import "AppDelegate.h"

@interface JQDemoViewControllerD42_2 () <AVAudioPlayerDelegate>

// 播放器封装
@property (nonatomic, strong) JQAudioManager *playerManager;

// 音乐播放列表
@property (nonatomic, strong) NSArray *musicList;

// 当前播放歌曲索引
@property (nonatomic, assign) NSInteger currentMusicIndex;

// 歌手图片
@property (nonatomic, strong) UIImageView *singerIconView;

// 播放时间滑块
@property (nonatomic, strong) UISlider *timeSlider;

@property (nonatomic, strong) UISlider *speedSlider;

@property (nonatomic, strong) UISlider *volumeSlider;

@end

@implementation JQDemoViewControllerD42_2

#pragma mark - getters and setters

- (NSArray *)musicList {
    
    if (!_musicList) {
        
        _musicList = [JQMusicModel loadMusicData];
    }
    
    return _musicList;
}

- (JQAudioManager *)playerManager {
    
    if (!_playerManager) {
        
        _playerManager = [JQAudioManager sharedAudioManager];
        
        // 默认加载第一首歌
        [_playerManager prepareToPlayMusic:self.musicList[self.currentMusicIndex]];
        
        // 设置总长度
        self.timeSlider.maximumValue = _playerManager.duration;
        
        // 播放进度回调
        __weak typeof(self) ws = self;
        
        [_playerManager setCurrentTimeBlock:^(NSTimeInterval currentTime) {
            
            ws.timeSlider.value = currentTime;
        }];
    }
    
    return _playerManager;
}

- (UIImageView *)singerIconView {
    
    if (!_singerIconView) {
        _singerIconView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 150, 200)];
        _singerIconView.centerX = self.view.centerX;
        _singerIconView.backgroundColor = [UIColor lightGrayColor];
    }
    return _singerIconView;
}

- (UISlider *)timeSlider {
    
    if (!_timeSlider) {
        _timeSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 300, 200, 20)];
        _timeSlider.centerX = self.view.centerX;
        [_timeSlider addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
        [_timeSlider addTarget:self action:@selector(timeTouchDown) forControlEvents:UIControlEventTouchDown];
        [_timeSlider addTarget:self action:@selector(timeTouchUp) forControlEvents:UIControlEventTouchUpInside];
        [_timeSlider addTarget:self action:@selector(timeTouchUp) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _timeSlider;
}

- (UISlider *)speedSlider {
    
    if (!_speedSlider) {
        _speedSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 350, 200, 20)];
        _speedSlider.centerX = self.view.centerX;
        [_speedSlider addTarget:self action:@selector(rateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _speedSlider;
}

- (UISlider *)volumeSlider {
    
    if (!_volumeSlider) {
        _volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 400, 200, 20)];
        _volumeSlider.centerX = self.view.centerX;
        [_volumeSlider addTarget:self action:@selector(voiceChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _volumeSlider;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.singerIconView];
    [self.view addSubview:self.timeSlider];
    [self.view addSubview:self.speedSlider];
    [self.view addSubview:self.volumeSlider];
 
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.frame = CGRectMake(50, 450, 100, 40);
    stopBtn.backgroundColor = [UIColor randomColor];
    [stopBtn setTitle:@"上一首" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(lastMusic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(50, 500, 100, 40);
    playBtn.backgroundColor = [UIColor randomColor];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseBtn.frame = CGRectMake(50, 550, 100, 40);
    pauseBtn.backgroundColor = [UIColor randomColor];
    [pauseBtn setTitle:@"下一首" forState:UIControlStateNormal];
    [pauseBtn addTarget:self action:@selector(nextMusic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    [self setUpSingerIcon:self.currentMusicIndex];
    
    // 响应用户远程点击事件
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app setReceivedWithEventBlock:^(UIEvent *event) {
       
        NSLog(@"%@",event);
        
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlNextTrack:
                [self nextMusic];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self lastMusic];
                break;
            case UIEventSubtypeRemoteControlPause:
                [self.playerManager pause];
                break;
            case UIEventSubtypeRemoteControlPlay:
                [self.playerManager play];
                break;
            default:
                break;
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.playerManager stop];
}

#pragma mark - event handle

// 按下 slider，开始拖拽
- (void)timeTouchDown {
    
    [self.playerManager pause];
}

// 结束拖拽
- (void)timeTouchUp {
    
    [self.playerManager play];
}

// 改变播放进度
- (void)timeChange:(UISlider *)sender {
    
    self.playerManager.currentTime = sender.value;
}

// 改变播放速度
- (void)rateChange:(UISlider *)sender {
    
    self.playerManager.rate = sender.value;
}

// 改变播放音量
- (void)voiceChange:(UISlider *)sender {
    
    self.playerManager.volume = sender.value;
}

// 上一首
- (void)lastMusic {
    
    NSInteger idx = self.currentMusicIndex == 0 ? self.musicList.count - 1 : self.currentMusicIndex - 1;
    
    [self changeMusic:idx];
}

// 下一首
- (void)nextMusic {
    
    NSInteger idx = (self.currentMusicIndex + 1) % self.musicList.count;
    
    [self changeMusic:idx];
}

// 切换音乐
- (void)changeMusic:(NSInteger)index {
    
    [self setUpSingerIcon:index];
    
    [self.playerManager prepareToPlayMusic:self.musicList[index]];
    
    [self.playerManager play];
    
    // 获取索引
    self.currentMusicIndex = index;
}

// 设置歌手图片
- (void)setUpSingerIcon:(NSInteger)index {
    
    JQMusicModel *music = self.musicList[index];
    
    self.singerIconView.image = [UIImage imageNamed:music.singerIcon];
}

- (void)playAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    // 修改按钮选中状态
    btn.selected = !btn.selected;
    
    [btn setTitle:btn.selected ? @"暂停" : @"开始" forState:UIControlStateNormal];
    
    // 若选中
    if (btn.selected) {
        // 判断是否为播放状态
        if (![self.playerManager isPlaying]) {
            // 播放
            [self.playerManager play];
        }
    } else {
        if ([self.playerManager isPlaying]) {
            // 暂停
            [self.playerManager pause];
        }
    }
}

@end
