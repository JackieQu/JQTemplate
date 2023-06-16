//
//  JQMessageCell.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/16.
//

#import <UIKit/UIKit.h>
#import "JQMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQMessageCell : UITableViewCell

@property (nonatomic, strong) JQMessageModel *message;

@end

NS_ASSUME_NONNULL_END
