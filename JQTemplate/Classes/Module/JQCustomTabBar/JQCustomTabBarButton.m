//
//  JQCustomTabBarButton.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/8.
//

#import "JQCustomTabBarButton.h"

@implementation JQCustomTabBarButton

- (void)setItem:(JQTabBarItemModel *)item {
    _item = item;
    
    if (_item.isSpecial) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor orangeColor].CGColor;
        self.clipsToBounds = YES;
    }
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted | UIControlStateSelected];
    [self setImage:[UIImage imageNamed:_item.imageNormal] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:_item.imageSelected] forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:_item.imageSelected] forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:_item.imageSelected] forState:UIControlStateHighlighted | UIControlStateSelected];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    if (self.item.isSpecial) {
        return CGRectZero;
    }

    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    if (self.item.isSpecial) {
        CGFloat imageX = contentRect.size.width / 4;
        CGFloat imageW = contentRect.size.width / 2;
        return CGRectMake(imageX, imageX, imageW, imageW);
    }
    
    return [super imageRectForContentRect:contentRect];
}

@end
