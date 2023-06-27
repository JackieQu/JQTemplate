//
//  JQImageListView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/27.
//

#import "JQImageListView.h"

@implementation JQImageListView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        for (NSInteger i = 0; i < 9; i ++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:imageView];
        }
    }
    return self;
}

- (void)setWeiboFrame:(JQWeiboFrame *)weiboFrame {
    
    _weiboFrame = weiboFrame;
    
    JQWeiboModel *obj = weiboFrame.weibo;
    
    for (NSInteger i = 0; i < [[self subviews] count]; i ++) {
        
        // 通过子视图获取 imageView
        UIImageView *imageView = [self subviews][i];
        
        // 处理图片展示或隐藏
        if (i >= obj.images.count) {
            
            imageView.hidden = YES;
            
        } else {
            
            imageView.hidden = NO;
            imageView.frame = [weiboFrame.imageFrames[i] CGRectValue];
            imageView.image = [UIImage imageNamed:obj.images[i]];
        }
    }
}

@end
