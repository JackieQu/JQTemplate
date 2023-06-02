//
//  JQCustomHUD.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQCustomHUD : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL needMask;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
