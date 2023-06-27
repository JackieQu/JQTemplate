//
//  JQGoodsCell.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/27.
//

#import "JQGoodsCell.h"

static CGFloat kMargin = 5;

@interface JQGoodsCell ()

@property (nonatomic, strong) UIImageView *goodsImageView;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *salesLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JQGoodsCell

- (void)setGoods:(JQGoodsModel *)goods {
    
    _goods = goods;
    
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",goods.image];
    self.goodsImageView.image = [UIImage imageNamed:imageName];
    self.priceLabel.text = [NSString stringWithFormat:@"¥: %@",goods.price];
    self.salesLabel.text = [NSString stringWithFormat:@"已售: %@",goods.sales];
    self.titleLabel.text = goods.title;
}

- (UIImageView *)goodsImageView {
    
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:16];
    }
    return _priceLabel;
}

- (UILabel *)salesLabel {
    
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.textAlignment = NSTextAlignmentRight;
        _salesLabel.font = [UIFont systemFontOfSize:16];
    }
    return _salesLabel;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.goodsImageView];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.salesLabel];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.backgroundColor = [UIColor grayColor].CGColor;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    self.goodsImageView.frame = CGRectMake(0, 0, width, height - 50);
    
    CGFloat priceY = CGRectGetMaxY(self.goodsImageView.frame);
    self.priceLabel.frame = CGRectMake(kMargin, priceY, (width - kMargin * 3) / 2, 25);
    
    self.salesLabel.frame = CGRectMake(CGRectGetMaxX(self.priceLabel.frame) + kMargin, priceY, CGRectGetWidth(self.priceLabel.frame), 25);
    
    self.titleLabel.frame = CGRectMake(kMargin, CGRectGetMaxY(self.priceLabel.frame), width - kMargin * 2, 25);
}

@end
