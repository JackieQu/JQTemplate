//
//  UIImageView+SDWebImage.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/18.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^JQImageDownloadSuccessBlock)(SDImageCacheType cacheType, UIImage *image);
typedef void(^JQImageDownloadFailureBlock)(NSError *error);
typedef void(^JQImageDownloadProgressBlock)(CGFloat progress);

@interface UIImageView (SDWebImage)

/**
 SDWebImage 下载并缓存图片

 @param url 图片地址
 @param placeholderImage 占位图片
 */
- (void)downloadImage:(NSString *)url
     placeholderImage:(UIImage *)placeholderImage;

/**
 SDWebImage 下载并缓存图片及下载进度

 @param url 图片地址
 @param placeholderImage 占位图片
 @param success 图片下载成功
 @param failure 图片下载失败
 @param progress 图片下载进度
 */
- (void)downloadImage:(NSString *)url
     placeholderImage:(UIImage *)placeholderImage
             progress:(JQImageDownloadProgressBlock)progress
              success:(JQImageDownloadSuccessBlock)success
              failure:(JQImageDownloadFailureBlock)failure;
             
@end

NS_ASSUME_NONNULL_END
