//
//  JQAlertView.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JQAlertView;

@protocol JQAlertViewDelegate <NSObject>

- (void)alertView:(JQAlertView *)alertView selectedAtIndex:(NSUInteger)index;

@end

@interface JQAlertView : UIView

@property (nonatomic, strong) id<JQAlertViewDelegate> delegate;

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
