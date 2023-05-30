//
//  UIColor+Hex.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "UIColor+Hex.h"

CGFloat getColorComponent(NSString *colorStr, NSUInteger loc, NSUInteger len) {
    
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
            r = getColorComponent(colorStr, 0, 1);
            g = getColorComponent(colorStr, 1, 1);
            b = getColorComponent(colorStr, 2, 1);
            break;
        case 4: // #ARGB
            a = getColorComponent(colorStr, 0, 1);
            r = getColorComponent(colorStr, 1, 1);
            g = getColorComponent(colorStr, 2, 1);
            b = getColorComponent(colorStr, 3, 1);
            break;
        case 6: // #RRGGBB
            a = 1.0f;
            r = getColorComponent(colorStr, 0, 2);
            g = getColorComponent(colorStr, 2, 2);
            b = getColorComponent(colorStr, 4, 2);
            break;
        case 8: // #AARRGGBB
            a = getColorComponent(colorStr, 0, 2);
            r = getColorComponent(colorStr, 2, 2);
            g = getColorComponent(colorStr, 4, 2);
            b = getColorComponent(colorStr, 6, 2);
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

@end
