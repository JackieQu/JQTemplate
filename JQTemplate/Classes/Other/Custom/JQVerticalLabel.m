//
//  JQVerticalLabel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQVerticalLabel.h"

#define kLineSpacing 5

@implementation JQVerticalLabel

- (instancetype)initWithVerticalText:(NSString *)str fontSize:(CGFloat)fontSize {
    
    if (self = [super init]) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = kLineSpacing;
        
        NSDictionary *dict = @{
            NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
            NSParagraphStyleAttributeName: style,
        };
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str attributes:dict];
        CGSize size = [str boundingRectWithSize:CGSizeMake(fontSize, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:dict
                                        context:nil].size;
        
        self.textAlignment = NSTextAlignmentCenter;
        self.lineBreakMode = NSLineBreakByCharWrapping;
        self.attributedText = attrStr;
        self.numberOfLines = 0;
        self.bounds = CGRectMake(0, 0, size.width, size.height);
    }
    return self;
}

@end
