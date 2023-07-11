//
//  JQLabelCell.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/11.
//

#import "JQLabelCell.h"

@interface JQLabelCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation JQLabelCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)setIndex:(NSInteger)index {
    
    _index = index;
    
    self.label.text = [NSString stringWithFormat:@"%@",@(index)];
}

- (UILabel *)label {
    
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:20];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.label.frame = self.bounds;
}

@end

