//
//  JQShopCell.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/16.
//

#import "JQShopCell.h"

static CGFloat kMargin = 10;

@interface JQShopCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UILabel *marketLabel;

@end

@implementation JQShopCell

- (void)setShop:(JQShopModel *)shop {
    _shop = shop;
    
    self.iconView.image = [UIImage imageNamed:shop.shop_image];
    self.nameLabel.text = shop.shop_name;
    self.descLabel.text = shop.shop_desc;
    NSDictionary *dict1 = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@ ",shop.p_price] attributes:dict1];
    NSDictionary *dict2 = @{
                            NSForegroundColorAttributeName:[UIColor grayColor],
                            NSFontAttributeName:[UIFont systemFontOfSize:14]
                            };
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"门市价：¥%@",shop.shop_price] attributes:dict2];
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] init];
    [priceString insertAttributedString:string1 atIndex:0];
    [priceString insertAttributedString:string2 atIndex:string1.length];
    self.priceLabel.attributedText = priceString;
    self.distanceLabel.text = shop.distance;
    self.marketLabel.text = [NSString stringWithFormat:@"已售：%@",shop.market];
}

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
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
    }
    return _priceLabel;
}

- (UILabel *)distanceLabel {
    
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
    }
    return _distanceLabel;
}

- (UILabel *)marketLabel {
    
    if (!_marketLabel) {
        _marketLabel = [[UILabel alloc] init];
        _marketLabel.font = [UIFont systemFontOfSize:12];
        _marketLabel.textAlignment = NSTextAlignmentRight;
    }
    return _marketLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.distanceLabel];
        [self.contentView addSubview:self.marketLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.contentView.frame);
    CGFloat height = CGRectGetHeight(self.contentView.frame);
    
    self.iconView.frame = CGRectMake(kMargin, kMargin, 80, height - kMargin * 2);
    self.distanceLabel.frame = CGRectMake(width - kMargin - 50, CGRectGetMinY(self.iconView.frame), 50, 12);
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + kMargin, CGRectGetMinY(self.iconView.frame), CGRectGetMinX(self.distanceLabel.frame) - CGRectGetMaxX(self.iconView.frame) - kMargin * 2, 20);
    self.descLabel.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame), width - CGRectGetMaxX(self.iconView.frame) - kMargin, 32);
    self.marketLabel.frame = CGRectMake(width - kMargin - 100, CGRectGetMaxY(self.descLabel.frame), 100, 12);
    self.priceLabel.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.descLabel.frame), CGRectGetMinX(self.marketLabel.frame) - CGRectGetMaxX(self.iconView.frame) - kMargin * 2, 17);
}

@end
