//
//  JQBaseViewController.h
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import <UIKit/UIKit.h>
#import "JQModalDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQBaseViewController : UIViewController

@property (nonatomic, weak) id<JQModalDelegate> modalDelegate;

- (void)initUI;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
