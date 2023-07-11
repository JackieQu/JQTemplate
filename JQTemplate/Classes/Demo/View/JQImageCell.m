//
//  JQImageCell.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/10.
//

#import "JQImageCell.h"

@interface JQImageCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JQImageCell

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    
    self.imageView.image = [UIImage imageNamed:imageName];
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

@end

