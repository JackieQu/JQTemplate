//
//  JQBlockButton.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import "JQBlockButton.h"

@implementation JQBlockButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickAction:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender);
    }
}

@end
