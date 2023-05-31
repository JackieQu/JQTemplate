//
//  JQLoginTextField.h
//  JQTemplate
//
//  Created by JackieQu on 2023/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQLoginTextField : UITextField

@property (nonatomic, copy) NSString *leftImageName;

- (instancetype)initWithFrame:(CGRect)frame leftImageName:(NSString *)leftImageName;

@end

NS_ASSUME_NONNULL_END
