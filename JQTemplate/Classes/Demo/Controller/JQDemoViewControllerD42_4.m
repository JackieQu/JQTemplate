//
//  JQDemoViewControllerD42_4.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQDemoViewControllerD42_4.h"
#import <AVFoundation/AVFoundation.h>

static NSString *identifier = @"cellID";

@interface JQDemoViewControllerD42_4 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation JQDemoViewControllerD42_4

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        
        _dataList = [NSMutableArray array];
    }
    
    return _dataList;
}

- (CADisplayLink *)link {
    
    if (!_link) {
        
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(change)];
    }
    
    return _link;
}

- (void)change {
    
    // 更新测量数据，只有 meteringEnabled == YES 时有效
    [self.recorder updateMeters];
    
    // 指定通道的测量平均值，只有调用完 updateMeters 才有值，注意音频强度范围是 -160 ～ 0
    float value = [self.recorder averagePowerForChannel:0];
    NSLog(@"%f",value);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_NAV_HEIGHT - 60)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:self.tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor randomColor];
    btn.frame = CGRectMake(0, self.tableView.bottom, SCREEN_WIDTH, 60);
    [btn setTitle:@"录音" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(touchUpIn) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(touchUpOut) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:btn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.textLabel.text = [self.dataList[indexPath.row] lastPathComponent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSURL *url = self.dataList[indexPath.row];
    
    NSError *error;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (error) {
        
        NSLog(@"%@",error);
        
    } else {
        
        [self.player play];
    }
}

- (void)touchDown {
    
    NSLog(@"开始录音");
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(13, 1, 1) lastObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd.HH:mm:ss";
    
    NSString *currentTimeStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *filename = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"record%lu@%@.caf",self.dataList.count + 1,currentTimeStr]];
    
    // 保存地址
    NSURL *url = [NSURL URLWithString:filename];
    
    // 录音参数
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    // 音频编码格式
    settings[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
    // 音频采样率
    settings[AVSampleRateKey] = @(8000);
    // 音频通道
    settings[AVNumberOfChannelsKey] = @(1);
    // 音频位深度
    settings[AVLinearPCMBitDepthKey] = @(8);
    
    NSError *error;
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if (error) {
        
        NSLog(@"录音信息配置失败：%@",error);
        
    } else {
        
        [self.dataList addObject:url];
        
        // 准备录音
        [self.recorder prepareToRecord];
        
        // 设置检测分贝数据
        self.recorder.meteringEnabled = YES;
        
        // 开启定时器
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
        // 录音
        [self.recorder record];
    }
}

- (void)touchUpIn {
    
    NSLog(@"结束录音");
    
    double currentTime = self.recorder.currentTime;
    
    // 结束录音
    [self.recorder stop];
    
    // 判断录音时长是否小于 2 秒
    if (currentTime < 2.0f) {
        
        // 删除沙盒中的录音（必须结束录音后才可以调用）
        [self.recorder deleteRecording];
        
        // 删除刚生成的 url
        [self.dataList removeLastObject];
        
    } else {
        
        // 刷新 tableView
        [self.tableView reloadData];
        
    }
    
    [self.link invalidate];
    
    self.link = nil;
}

- (void)touchUpOut {
    
    NSLog(@"取消录音");
    
    [self.recorder stop];
    
    [self.recorder deleteRecording];
    
    [self.dataList removeLastObject];
    
    [self.link invalidate];
    
    self.link = nil;
}

@end
