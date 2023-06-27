//
//  JQWeiboEstimateHeightCell.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/27.
//

#import <UIKit/UIKit.h>
#import "JQWeiboModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQWeiboEstimateHeightCell : UITableViewCell

- (CGFloat)cellHeightAfterBindData:(JQWeiboModel *)weibo;

@end

NS_ASSUME_NONNULL_END
