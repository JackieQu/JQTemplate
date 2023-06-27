//
//  JQWeiboEstimateHeightCell.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/27.
//

#import "JQWeiboEstimateHeightCell.h"

static CGFloat kFontSize = 16;
static CGFloat kMargin = 10;
static CGFloat kIconW = 50;

@interface JQWeiboEstimateHeightCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *subLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JQWeiboEstimateHeightCell

- (CGFloat)cellHeightAfterBindData:(JQWeiboModel *)weibo {
    
    _iconView.frame = CGRectMake(kMargin, kMargin, kIconW, kIconW);
    _iconView.image = [UIImage imageNamed:weibo.icon];
    
    CGFloat nameW = SCREEN_WIDTH - CGRectGetMaxX(_iconView.frame) - kMargin * 2;
    CGFloat nameX = CGRectGetMaxX(_iconView.frame) + kMargin;
    _nameLabel.frame = CGRectMake(nameX, kMargin, nameW, kFontSize);
    _nameLabel.text = weibo.name;
    
    CGFloat subY = CGRectGetMaxY(_nameLabel.frame) + kMargin;
    _subLabel.frame = CGRectMake(nameX, subY, nameW, 12);
    _subLabel.text = [NSString stringWithFormat:@"%@ 来自 %@",weibo.timer,weibo.from];
    
    CGFloat titleW = SCREEN_WIDTH - kMargin * 2;
    CGFloat titleY = CGRectGetMaxY(_iconView.frame) + kMargin;
    _titleLabel.frame = CGRectMake(kMargin, titleY, titleW, 0);
    _titleLabel.text = weibo.title;
    [_titleLabel sizeToFit];
    
    CGFloat cellHeight = CGRectGetMaxY(_titleLabel.frame) + kMargin;
    return cellHeight;
}

- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = kIconW / 2;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor orangeColor];
    }
    return _nameLabel;
}

- (UILabel *)subLabel {
    
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] init];
        _subLabel.textColor = [UIColor grayColor];
    }
    return _subLabel;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:kFontSize];
    }
    return _titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.subLabel];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

@end
