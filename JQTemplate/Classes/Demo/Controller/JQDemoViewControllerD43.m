//
//  JQDemoViewControllerD43.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQDemoViewControllerD43.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

static NSString *mp4Url = @"https://www.runoob.com/try/demo_source/movie.mp4";

@interface JQDemoViewControllerD43 ()

//@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation JQDemoViewControllerD43

- (AVPlayer *)player {
    
    if (!_player) {
        
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:mp4Url]];
        
        _player = [AVPlayer playerWithPlayerItem:item];
        
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        
        CGFloat playerW = SCREEN_WIDTH * 0.8;
        CGFloat playerH = playerW * 9 / 16;
        CGFloat playerX = (SCREEN_WIDTH - playerW) / 2;
        CGFloat playerY = 20;
        
        layer.frame = CGRectMake(playerX, playerY, playerW, playerH);
        
        [self.view.layer addSublayer:layer];
    }
    
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 创建视频播放实例
//    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:mp4Url]];
//
//    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
//
//    self.moviePlayer.view.frame = CGRectMake(0, 20, 320, 180);
//    self.moviePlayer.view.centerX = self.view.centerX;
//
//    [self.view addSubview:self.moviePlayer.view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self playAction];
}

- (void)playAction {
    
//    [self.moviePlayer play];
}

- (void)playAction2 {
    
//    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:mp4Url]];
//
//    [self presentViewController:moviePlayer animated:YES completion:nil];
}

- (void)playAction3 {
    
    [self.player play];
}

- (void)playAction4 {
    
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];

    AVPlayer *player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:mp4Url]];

    playerVC.player = player;

    [self presentViewController:playerVC animated:YES completion:nil];
}

@end
