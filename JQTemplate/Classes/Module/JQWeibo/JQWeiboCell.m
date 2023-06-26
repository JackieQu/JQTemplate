//
//  JQWeiboCell.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/26.
//

#import "JQWeiboCell.h"

@interface JQWeiboCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *subLabel;

@property (nonatomic, strong) UILabel *titleLabel;

//@property (nonatomic, strong) QPImageListView *imageListView;

@end

@implementation JQWeiboCell

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

//- (QPImageListView *)imageListView {
//
//    if (!_imageListView) {
//        _imageListView = [[QPImageListView alloc] init];
//    }
//    return _imageListView;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.subLabel];
        [self.contentView addSubview:self.titleLabel];
//        [self.contentView addSubview:self.imageListView];
    }
    return self;
}

- (void)setWeiboFrame:(JQWeiboFrame *)weiboFrame {
    
    _weiboFrame = weiboFrame;
    
    JQWeiboModel *obj = weiboFrame.weibo;
    
    _iconView.image = [UIImage imageNamed:obj.icon];
    _iconView.frame = weiboFrame.iconFrame;
    
    _nameLabel.text = obj.name;
    _nameLabel.frame = weiboFrame.nameFrame;
    
    _subLabel.text = [NSString stringWithFormat:@"%@ 来自 %@",obj.timer,obj.from];
    _subLabel.frame = weiboFrame.subFrame;
 
    _titleLabel.text = obj.title;
    _titleLabel.frame = weiboFrame.titleFrame;
    
//    _imageListView.frame = weiboFrame.imageListViewFrame;
//    _imageListView.weiboFrame = weiboFrame;
}

@end
