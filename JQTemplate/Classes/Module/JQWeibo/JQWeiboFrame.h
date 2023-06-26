//
//  JQWeiboFrame.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/26.
//

#import <Foundation/Foundation.h>
#import "JQWeiboModel.h"

NS_ASSUME_NONNULL_BEGIN

static CGFloat kFontSize = 16;
static CGFloat kMargin = 10;
static CGFloat kIconW = 50;

@interface JQWeiboFrame : NSObject

@property (nonatomic, strong) JQWeiboModel *weibo;

@property (nonatomic, assign) CGRect iconFrame;

@property (nonatomic, assign) CGRect nameFrame;

@property (nonatomic, assign) CGRect subFrame;

@property (nonatomic, assign) CGRect titleFrame;

@property (nonatomic, assign) CGRect imageListViewFrame;

@property (nonatomic, strong) NSArray *imageFrames;

@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
