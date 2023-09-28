//
//  JQHUDHelper.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import "JQHUDHelper.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation JQHUDHelper

+ (void)load {
    
//    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
}

+ (void)showProgressMessage:(NSString *)message {
    
    [SVProgressHUD setContainerView:[UIApplication sharedApplication].windows.firstObject];
    [SVProgressHUD showWithStatus:message];
}

+ (void)showInfoMessage:(NSString *)message {
    
    [SVProgressHUD setContainerView:[UIApplication sharedApplication].windows.firstObject];
    [SVProgressHUD showInfoWithStatus:message];
}

+ (void)showSuccessMessage:(NSString *)message {
    
    [SVProgressHUD setContainerView:[UIApplication sharedApplication].windows.firstObject];
    [SVProgressHUD showSuccessWithStatus:message];
}

+ (void)showErrorMessage:(NSString *)message {
 
    [SVProgressHUD setContainerView:[UIApplication sharedApplication].windows.firstObject];
    [SVProgressHUD showErrorWithStatus:message];
}

+ (void)dismissHUD {
    
    [SVProgressHUD dismiss];
}

@end
