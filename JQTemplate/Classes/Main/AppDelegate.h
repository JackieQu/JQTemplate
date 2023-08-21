//
//  AppDelegate.h
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

@property (strong, nonatomic) UIWindow *window;

- (void)saveContext;

@end
