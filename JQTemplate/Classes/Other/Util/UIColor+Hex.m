//
//  UIColor+Hex.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "UIColor+Hex.h"

CGFloat ColorComponent(NSString *colorStr, NSUInteger loc, NSUInteger len) {
    
    NSString *subStr = [colorStr substringWithRange:NSMakeRange(loc, len)];
    NSString *hexStr = len == 2 ? subStr : [subStr stringByAppendingString:subStr];
    
    unsigned result;
    [[NSScanner scannerWithString: hexStr] scanHexInt: &result];
    return result / 255.0f;
}

@implementation UIColor (Hex)

#pragma mark - hex

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    
    return [UIColor colorWithRed:((hex >> 16) & 0xFF) / 255.0f
                           green:((hex >> 8) & 0xFF) / 255.0f
                            blue:(hex & 0xFF) / 255.0f
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(UInt32)hex {
    
    return [UIColor colorWithHex:hex alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexStr {
    
    CGFloat r, g, b, a;
    
    NSString *colorStr = [[hexStr stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorStr length]) {
        case 3: // #RGB
            a = 1.0f;
            r = ColorComponent(colorStr, 0, 1);
            g = ColorComponent(colorStr, 1, 1);
            b = ColorComponent(colorStr, 2, 1);
            break;
        case 4: // #ARGB
            a = ColorComponent(colorStr, 0, 1);
            r = ColorComponent(colorStr, 1, 1);
            g = ColorComponent(colorStr, 2, 1);
            b = ColorComponent(colorStr, 3, 1);
            break;
        case 6: // #RRGGBB
            a = 1.0f;
            r = ColorComponent(colorStr, 0, 2);
            g = ColorComponent(colorStr, 2, 2);
            b = ColorComponent(colorStr, 4, 2);
            break;
        case 8: // #AARRGGBB
            a = ColorComponent(colorStr, 0, 2);
            r = ColorComponent(colorStr, 2, 2);
            g = ColorComponent(colorStr, 4, 2);
            b = ColorComponent(colorStr, 6, 2);
            break;
        default:
            return nil;
    }
    
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

- (NSString *)hexString {
    
    UIColor* color = self;
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%02X%02X%02X",
            (int)((CGColorGetComponents(color.CGColor))[0] * 255.0f),
            (int)((CGColorGetComponents(color.CGColor))[1] * 255.0f),
            (int)((CGColorGetComponents(color.CGColor))[2] * 255.0f)];
}

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

+ (UIColor *)colorWithNormalHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    
    NSString *colorStr = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([colorStr length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([colorStr hasPrefix:@"#"])
        colorStr = [colorStr substringFromIndex:1];
    if ([colorStr length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rStr = [colorStr substringWithRange:range];
    range.location = 2;
    NSString *gStr = [colorStr substringWithRange:range];
    range.location = 4;
    NSString *bStr = [colorStr substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)colorWithNormalHexString:(NSString *)hexStr {
    return [UIColor colorWithNormalHexString:hexStr alpha:1.0];
}

@end
