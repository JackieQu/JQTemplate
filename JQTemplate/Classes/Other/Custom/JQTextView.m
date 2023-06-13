//
//  JQTextView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQTextView.h"

@implementation JQTextView

- (UILabel *)placeholderLabel {
    
    if (!_placeholderLabel) {
        CGFloat margin = ADAPT_VALUE(5);
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, self.frame.size.width - margin * 2, self.font.lineHeight + 2)];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.text = @"请输入...";
    }
    return _placeholderLabel;
}

- (void)setFont:(UIFont *)font {
    
    self.placeholderLabel.font = font;
    CGFloat margin = ADAPT_VALUE(5);
    self.placeholderLabel.frame = CGRectMake(margin, margin, self.bounds.size.width - margin * 2, font.lineHeight + 2);
    
    [super setFont:font];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.placeholderLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textDidChangeNotification:(NSNotification *)notice {
    
    self.placeholderLabel.hidden = self.text.length != 0;
}

@end
