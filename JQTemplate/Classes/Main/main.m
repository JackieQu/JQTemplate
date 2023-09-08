//
//  main.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

CFAbsoluteTime startTime;

int main(int argc, char * argv[]) {
    startTime = CFAbsoluteTimeGetCurrent();
    NSString *appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
