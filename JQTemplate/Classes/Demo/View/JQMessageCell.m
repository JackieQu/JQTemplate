//
//  JQMessageCell.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/16.
//

#import "JQMessageCell.h"

static NSInteger kMargin = 10;

@interface JQMessageCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation JQMessageCell

- (void)setMessage:(JQMessageModel *)message {
    _message = message;
    
    self.iconView.image = [UIImage imageNamed:message.icon];
    self.nameLabel.text = message.name;
    self.timeLabel.text = message.time;
    self.messageLabel.text = message.message;
}

- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UILabel *)messageLabel {
    
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor grayColor];
        _messageLabel.font = [UIFont systemFontOfSize:15];
    }
    return _messageLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}

// 当执行 addSubview 时布局子视图
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    self.iconView.frame = CGRectMake(kMargin, kMargin, height - kMargin * 2, height - kMargin * 2);
    self.nameLabel.frame = CGRectMake(CGRectGetWidth(self.iconView.frame) + kMargin * 2, CGRectGetMinY(self.iconView.frame), 200, 20);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + kMargin,CGRectGetMinY(self.nameLabel.frame),width - CGRectGetMaxX(self.nameLabel.frame) - kMargin * 2, 20);
    self.messageLabel.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame) + kMargin, width - CGRectGetWidth(self.iconView.frame) - kMargin * 3, 20);
}

@end
