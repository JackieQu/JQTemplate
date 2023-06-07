//
//  UIBarButtonItem+Extension.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/7.
//

#import <UIKit/UIKit.h>

#define kNormalColor [UIColor grayColor]
#define kHighlightedColor [UIColor orangeColor]
#define kFontSize 17

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)

- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)hColor target:(id)target action:(SEL)action;
+ (instancetype)itemWithTitle:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)hColor target:(id)target action:(SEL)action;

- (instancetype)initWithImageName:(NSString *)imageName highlightedImageName:(NSString *)hImageName target:(id)target action:(SEL)action;
+ (instancetype)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)hImageName target:(id)target action:(SEL)action;

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
