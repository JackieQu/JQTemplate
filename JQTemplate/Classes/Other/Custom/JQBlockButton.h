//
//  JQBlockButton.h
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^JQClickBlock)(UIButton *sender);

@interface JQBlockButton : UIButton

@property (nonatomic, copy) JQClickBlock block;

@end

NS_ASSUME_NONNULL_END
