//
//  JQWeiboFrame.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/26.
//

#import "JQWeiboFrame.h"

@implementation JQWeiboFrame

- (void)setWeibo:(JQWeiboModel *)weibo {
    
    _weibo = weibo;
    
    _iconFrame = CGRectMake(kMargin, kMargin, kIconW, kIconW);
    
    CGFloat nameW = SCREEN_WIDTH - CGRectGetMaxX(_iconFrame) - kMargin * 2;
    CGFloat nameX = CGRectGetMaxX(_iconFrame) + kMargin;
    
    _nameFrame = CGRectMake(nameX, kMargin, nameW, kFontSize);
    
    CGFloat subY = CGRectGetMaxY(_nameFrame) + kMargin;
    
    _subFrame = CGRectMake(nameX, subY, nameW, 12);
    
    CGFloat titleW = SCREEN_WIDTH - kMargin * 2;
    CGFloat titleY = CGRectGetMaxY(_iconFrame) + kMargin;
    
    NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]};
    
    CGFloat titleH = [_weibo.title boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:fontDict context:nil].size.height;
    
    _titleFrame = CGRectMake(kMargin, titleY, titleW, titleH);
    
    
    if (weibo.images.count) {
        
        // 计算所有图片的大小，获取图片 frame 的集合
        
        _imageFrames = [self sizeWithImages];
        
        CGRect lastRect = [[_imageFrames lastObject] CGRectValue];
        
        CGFloat imageListViewY = CGRectGetMaxY(_titleFrame) + kMargin;
        
        // 展示图片视图 frame
        _imageListViewFrame = CGRectMake(0, imageListViewY, SCREEN_WIDTH, CGRectGetMaxY(lastRect));
        
        _cellHeight = CGRectGetMaxY(_imageListViewFrame) + kMargin;
    
    } else {
     
        _imageListViewFrame = CGRectZero;
        _cellHeight = CGRectGetMaxY(_titleFrame) + kMargin;
    }
}

- (NSArray *)sizeWithImages {
    
    // 仅一张图片时
    if (_weibo.images.count == 1) {
    
        NSString *imageName = [_weibo.images firstObject];
        UIImage *image = [UIImage imageNamed:imageName];
        
        BOOL isHorizontal = image.size.width > image.size.height;
        
        CGFloat imageW = isHorizontal ? 300 : 200;
        CGFloat imageH = image.size.height / image.size.width * imageW;
        
        CGRect imageRect = CGRectMake(kMargin, kMargin, imageW, imageH);
        NSValue *imageValue = [NSValue valueWithCGRect:imageRect];
        
        return @[imageValue];
    }
    
    // 多张图片时
    NSMutableArray *imageFrames = [NSMutableArray array];
    
    for (NSInteger i = 0; i < _weibo.images.count; i ++) {
        
        CGFloat width = (SCREEN_WIDTH - kMargin * 3) / 3;
        
        NSInteger x = i % 3;
        NSInteger y = i / 3;
        
        CGRect imageFrame = CGRectMake(kMargin + (width + kMargin / 2) * x, kMargin + (width + kMargin / 2) * y, width, width);
        NSValue *imageValue = [NSValue valueWithCGRect:imageFrame];
        
        [imageFrames addObject:imageValue];
    }
    
    return imageFrames;
}

@end
