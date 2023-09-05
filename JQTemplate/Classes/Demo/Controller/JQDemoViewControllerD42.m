//
//  JQDemoViewControllerD42.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQDemoViewControllerD42.h"
#import "JQAudioManager.h"
#import <AVFoundation/AVFoundation.h>

@interface JQDemoViewControllerD42 () <AVAudioPlayerDelegate>

// 定时器
@property (nonatomic, strong) CADisplayLink *link;

// 播放本地音乐
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

// 播放时间滑块
@property (nonatomic, strong) UISlider *timeSlider;

@property (nonatomic, strong) UISlider *speedSlider;

@property (nonatomic, strong) UISlider *volumeSlider;

@end

@implementation JQDemoViewControllerD42

#pragma mark - getters and setters

- (CADisplayLink *)link {
    
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(change)];
    }
    
    return _link;
}

- (AVAudioPlayer *)audioPlayer {
    
    if (!_audioPlayer) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"北京北京" withExtension:@"mp3"];
        NSError *error;
        // 实例化播放对象
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _audioPlayer.delegate = self;
        
        if (error) {
            JQLog(@"初始化失败：%@",error);
        } else {
            
            // 准备开始播放，缓冲数据
            [_audioPlayer prepareToPlay];
            
            // 是否允许快进
            _audioPlayer.enableRate = YES;
            
            // 设置播放次数
            // -1: 无限循环，0: 一次，1: 两次...
            _audioPlayer.numberOfLoops = 0;
            
            // slider 最大值，duration 音乐的总时长
            self.timeSlider.maximumValue = _audioPlayer.duration;
        }
    }
    return _audioPlayer;
}

- (UISlider *)timeSlider {
    
    if (!_timeSlider) {
        _timeSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 100, 200, 20)];
        [_timeSlider addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
        [_timeSlider addTarget:self action:@selector(timeTouchDown) forControlEvents:UIControlEventTouchDown];
        [_timeSlider addTarget:self action:@selector(timeTouchUp) forControlEvents:UIControlEventTouchUpInside];
        [_timeSlider addTarget:self action:@selector(timeTouchUp) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _timeSlider;
}

- (UISlider *)speedSlider {
    
    if (!_speedSlider) {
        _speedSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 150, 200, 20)];
        [_speedSlider addTarget:self action:@selector(rateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _speedSlider;
}

- (UISlider *)volumeSlider {
    
    if (!_volumeSlider) {
        _volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 200, 200, 20)];
        [_volumeSlider addTarget:self action:@selector(voiceChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _volumeSlider;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.timeSlider];
    [self.view addSubview:self.speedSlider];
    [self.view addSubview:self.volumeSlider];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.frame = CGRectMake(50, 250, 100, 40);
    stopBtn.backgroundColor = [UIColor randomColor];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(50, 300, 100, 40);
    playBtn.backgroundColor = [UIColor randomColor];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseBtn.frame = CGRectMake(50, 350, 100, 40);
    pauseBtn.backgroundColor = [UIColor randomColor];
    [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [pauseBtn addTarget:self action:@selector(pauseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playInterruption:) name:AVAudioSessionInterruptionNotification object:session];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopAction];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 了解
- (void)playInterruption:(NSNotification *)notify {
    
    if (notify.userInfo.allKeys.count == 2) {
        JQLog(@"结束中断");
    } else {
        JQLog(@"开始中断");
    }
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    JQLog(@"播放完成");
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    
    JQLog(@"error: %@",error);
}

// iOS 8 中断方法
//- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
//
//    JQLog(@"开始中断");
//
//    [self.audioPlayer pause];
//}
//
//- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
//
//    JQLog(@"结束中断");
//
//    [self.audioPlayer play];
//}

#pragma mark - event handle

- (void)change {

    // 获取当前时间，重置播放进度
    self.timeSlider.value = self.audioPlayer.currentTime;
}

// 按下 slider，开始拖拽
- (void)timeTouchDown {

    // 停止播放
    [self.audioPlayer pause];
}

// 结束拖拽
- (void)timeTouchUp {

    // 继续播放
    [self.audioPlayer play];
}

// 改变播放进度
- (void)timeChange:(UISlider *)sender {

    self.audioPlayer.currentTime = sender.value;
}

// 改变播放速度
- (void)rateChange:(UISlider *)sender {

    // 默认为 1，在 0.5 ～ 2 之间改变
    self.audioPlayer.rate = sender.value;
}

// 改变播放音量
- (void)voiceChange:(UISlider *)sender {

    // 0 ～ 1 之间
    self.audioPlayer.volume = sender.value;
}

- (void)stopAction {

    // 停止
    [self.audioPlayer stop];

    // 清空内存
    self.audioPlayer = nil;

    // 停止定时器
    [self.link invalidate];
    self.link = nil;
}

- (void)playAction {

    // 判断播放状态
    if (![self.audioPlayer isPlaying]) {

        // 添加定时器到 RunLoop 中
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

        [self.audioPlayer play];
    }
}

- (void)pauseAction {

    // 暂停
    if ([self.audioPlayer isPlaying]) {

        [self.audioPlayer pause];

        // 暂停 CADisplayLink
        [self.link invalidate];
        self.link = nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [[JQAudioManager sharedAudioManager] playSystemSound:@"yaobuqi.wav"];
}

@end
