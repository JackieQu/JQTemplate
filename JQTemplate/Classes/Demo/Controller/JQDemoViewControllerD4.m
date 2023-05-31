//
//  JQDemoViewControllerD4.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import "JQDemoViewControllerD4.h"
#import "JQBlockButton.h"
#import "JQDockButton.h"

@interface JQDemoViewControllerD4 ()

@property (nonatomic, strong) JQBlockButton *blockBtn;

@end

@implementation JQDemoViewControllerD4

- (JQBlockButton *)blockBtn {
    
    if (!_blockBtn) {
        _blockBtn = [JQBlockButton buttonWithType:UIButtonTypeCustom];
        _blockBtn.frame = CGRectMake(100, 100, 100, 40);
        _blockBtn.backgroundColor = [UIColor orangeColor];
        _blockBtn.block = ^(UIButton * _Nonnull sender) {
            JQLog(@"%@", sender);
        };
    }
    return _blockBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.blockBtn];
    
    NSArray *titleArr = @[
        @"会议信息",    @"会议日程",    @"会议讲者",
        @"会议报道",    @"会议摘要",    @"会议讨论",
        @"报名须知",    @"参会注册",    @"地图",
        @"照片墙",
    ];
    NSArray *nameArr = @[
        @"meeting_info_n",      @"meeting_schedule_n",  @"meeting_guest_n",
        @"meeting_new_n",       @"meeting_other_n",     @"meeting_community_n",
        @"meeting_notice_n",    @"meeting_register_n",  @"meeting_map_n",
        @"meeting_image_n",
    ];
    
    CGFloat top    = 200;
    CGFloat margin = 40;
    CGFloat width  = (CGRectGetWidth(self.view.frame) - margin * 4) / 3;
    CGFloat height = width + 20;

    for (int i = 0; i < titleArr.count; i ++) {
        JQDockButton *btn = [JQDockButton buttonWithType:UIButtonTypeCustom];
        CGFloat pointX = i % 3;
        CGFloat pointY = i / 3;
        if (i == 9) {
            pointX = (i + 1) % 3;
        }
        CGFloat marignX = margin * (pointX + 1);
        CGFloat marignY = margin * (pointY + 1);
        btn.frame = CGRectMake(pointX * width + marignX, pointY * height + marignY + top, width, height);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:nameArr[i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
    
    /*
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 200);
    [btn setTitle:@"Normal" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"choose_n"] forState:UIControlStateNormal];
    
    [btn setTitle:@"Highlighted" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
//    [btn setEnabled:NO];
    [btn setTitle:@"Disabled" forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
//    [btn setSelected:YES];
    [btn setTitle:@"Selected" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"choose_s"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"choose_bg"] forState:UIControlStateSelected];
    
//    NSDictionary *dict = @{
//        NSFontAttributeName: [UIFont systemFontOfSize:20],
//        NSForegroundColorAttributeName: [UIColor purpleColor],
//    };
//    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"标题" attributes:dict];
//    [btn setAttributedTitle:attrStr forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btn removeTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(clickActionOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [btn addTarget:self action:@selector(clickActionAllEvents:) forControlEvents:UIControlEventAllEvents];
    
    btn.adjustsImageWhenHighlighted = NO;
    btn.showsTouchWhenHighlighted = YES;
    [self.view addSubview:btn];
     */
}

- (void)clickAction:(UIButton *)sender {
    JQLogFunction
    
    sender.selected = !sender.selected;
}

- (void)clickActionOutside:(UIButton *)sender {
    JQLogFunction
}

- (void)clickActionAllEvents:(UIButton *)sender {
    JQLogFunction
}

@end
