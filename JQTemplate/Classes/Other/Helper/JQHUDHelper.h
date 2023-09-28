//
//  JQHUDHelper.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQHUDHelper : NSObject

// 弹出加载进度信息提示框
+ (void)showProgressMessage:(NSString *)message;

// 弹出用户信息
+ (void)showInfoMessage:(NSString *)message;

// 弹出操作成功信息提示框
+ (void)showSuccessMessage:(NSString *)message;

// 弹出操作错误信息提示框
+ (void)showErrorMessage:(NSString *)message;

// 隐藏提示框
+ (void)dismissHUD;

@end

NS_ASSUME_NONNULL_END
