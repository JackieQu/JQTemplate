//
//  JQDemoViewControllerD42_3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQDemoViewControllerD42_3.h"
#import "JQMusicModel.h"
#import <AVFoundation/AVFoundation.h>

@interface JQDemoViewControllerD42_3 ()

// 音乐播放列表
@property (nonatomic, strong) NSArray *musicList;

// 当前音乐索引
@property (nonatomic, assign) NSInteger currentIndex;

// 网络音乐播放器
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) UIImageView *singerImage;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UISlider *timeSlider;

@end

@implementation JQDemoViewControllerD42_3

#pragma mark - getters and setters

- (UIImageView *)singerImage {
    
    if (!_singerImage) {
        _singerImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 150, 200)];
        _singerImage.centerX = self.view.centerX;
        _singerImage.backgroundColor = [UIColor lightGrayColor];
    }
    return _singerImage;
}

- (UIProgressView *)progressView {
    
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 300, 200, 20)];
        _progressView.centerX = self.view.centerX;
    }
    return _progressView;
}

- (UISlider *)timeSlider {
    
    if (!_timeSlider) {
        _timeSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 350, 200, 20)];
        _timeSlider.centerX = self.view.centerX;
        [_timeSlider addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _timeSlider;
}

- (NSArray *)musicList {
    
    if (!_musicList) {
        
        _musicList = [JQMusicModel loadNetMusicData];
    }
    
    return _musicList;
}

- (AVPlayer *)player {
    
    if (!_player) {
        
        JQMusicModel *music = self.musicList[self.currentIndex];
        
        NSURL *url = [NSURL URLWithString:music.url];
        
//        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
//
//        _player = [AVPlayer playerWithPlayerItem:playerItem];
        
        [self createPlayerItem:url];
        
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];
    }
    
    return _player;
}

- (void)createPlayerItem:(NSURL *)url {
    
    if (self.playerItem) {
        
        // 若 playerItem 已存在，则说明该 item 已经有 KVO 检测，移除 KVO
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    }
    
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    
    // 网络音乐需要缓冲，若在缓冲期间调用 currentTime，则系统会崩溃，所以一定要等待缓冲完成，再监测进度
    // KVO 检测 AVPlayerStatus status 属性的变化
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

// KVO 检测回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    // 判断 status 的变化
    if ([keyPath isEqualToString:@"status"]) {
        [self statusChange];
    }
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        [self loadTimeChange];
    }
}

- (void)statusChange {
    
    AVPlayerItemStatus status = self.player.currentItem.status;
    
    if (status == AVPlayerItemStatusReadyToPlay) {
        
        NSLog(@"准备播放：%@",[self.musicList[self.currentIndex] title]);
    
        // CMTime 为播放音频、视频的时间
        // 获取当前音频时长，设置音频总时长
        self.timeSlider.maximumValue = CMTimeGetSeconds(self.player.currentItem.duration);
        
        // 定时获取播放进度
        __weak typeof(self) ws = self;
        
        [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
         
            CGFloat currentTime = CMTimeGetSeconds(time);
            
            ws.timeSlider.value = currentTime;
        
        }];
        
    } else if (status == AVPlayerItemStatusFailed) {
        
        NSLog(@"播放失败");
    
        // 音乐链接来自网易云音乐，若播放失败，可能资源过期
        NSLog(@"%@",[self.musicList[self.currentIndex] url]);
    }
}

// 监测缓冲变化
- (void)loadTimeChange {
    
    // 获取缓冲范围
    CMTimeRange timeRnage = [[self.player.currentItem.loadedTimeRanges firstObject] CMTimeRangeValue];
    // 本次之前缓冲时长
    CGFloat startTime = CMTimeGetSeconds(timeRnage.start);
    // 本次缓冲时长
    CGFloat durationTime = CMTimeGetSeconds(timeRnage.duration);
    // 获取缓冲总时长
    CGFloat totalTime = startTime + durationTime;
    // 获取音乐总时长
    CGFloat musicTime = CMTimeGetSeconds(self.player.currentItem.duration);
    
    // 获取缓冲进度
    self.progressView.progress = totalTime / musicTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.singerImage.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.singerImage];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.timeSlider];
    
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
    
    [self changeSingerImage:self.currentIndex];
}

- (void)dealloc {
    
    // 移除 KVO
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)playAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    // 切换选中状态
    btn.selected = !btn.selected;
    
    [btn setTitle:btn.selected ? @"暂停" : @"开始" forState:UIControlStateNormal];
    
    if (btn.selected) {
        [self.player play];
    } else {
        [self.player pause];
    }
}

- (void)lastMusic {
    
    NSInteger index = self.currentIndex == 0 ? self.musicList.count - 1 : self.currentIndex - 1;
    
    [self changeMusic:index];
}

- (void)nextMusic {
    
    NSInteger index = (self.currentIndex + 1) % self.musicList.count;
    
    [self changeMusic:index];
}

- (void)changeMusic:(NSInteger)index {
    
    JQMusicModel *music = self.musicList[index];
    
    NSURL *url = [NSURL URLWithString:music.url];
    
//    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    [self createPlayerItem:url];
    
    // 切换音乐
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    
    [self changeSingerImage:index];
    
    self.currentIndex = index;
}

- (void)changeSingerImage:(NSInteger)index {
    
    NSURL *url = [NSURL URLWithString:[self.musicList[index] pic]];
    
    self.singerImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

- (void)timeChange:(UISlider *)sender {
    
    // 指定播放位置
    [self.player seekToTime:CMTimeMake(sender.value, 1)];
}

@end
