//
//  JQHUDHelper.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#import "JQHUDHelper.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation JQHUDHelper

+ (void)showInfoMessage:(NSString *)message {
    
    [SVProgressHUD showInfoWithStatus:message];
}

+ (void)showErrorMessage:(NSString *)message {
 
    [SVProgressHUD showErrorWithStatus:message];
}

+ (void)showSuccessMessage:(NSString *)message {
    
    [SVProgressHUD showSuccessWithStatus:message];
}

+ (void)showProgressMessage:(NSString *)message {
    
    [SVProgressHUD showWithStatus:message];
}

+ (void)dismissHUD {
    
    [SVProgressHUD dismiss];
}

@end
