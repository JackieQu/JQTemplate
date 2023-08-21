//
//  JQElmShopCell.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import "JQElmShopCell.h"
#import "UIImageView+SDWebImage.h"

static CGFloat kMargin = 10;

@interface JQElmShopCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation JQElmShopCell

- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UILabel *)descLabel {
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
    }
    return _descLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.descLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat iconViewW = 60;
    self.iconView.frame = CGRectMake(kMargin, kMargin, iconViewW, iconViewW);
    
    CGFloat nameLabelX = CGRectGetMaxX(self.iconView.frame) + kMargin;
    CGFloat nameLabelY = CGRectGetMinY(self.iconView.frame);
    CGFloat nameLabelW = SCREEN_WIDTH - nameLabelX - kMargin;
    self.nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, 20);
    
    CGFloat descLabelY = CGRectGetMaxY(self.nameLabel.frame) + kMargin;
    self.descLabel.frame = CGRectMake(nameLabelX, descLabelY, nameLabelW, 20);
}


- (void)setShop:(JQElmShopModel *)shop {
    
    _shop = shop;
    [self.iconView downloadImage:shop.image_path placeholderImage:[UIImage new]];
    self.nameLabel.text = shop.name;
    self.descLabel.text = shop.desc;
}

@end
