//
//  UIImageView+SDWebImage.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/18.
//

#import "UIImageView+SDWebImage.h"

@implementation UIImageView (SDWebImage)

- (void)downloadImage:(NSString *)url
     placeholderImage:(UIImage *)placeholderImage {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

- (void)downloadImage:(NSString *)url
     placeholderImage:(UIImage *)placeholderImage
             progress:(JQImageDownloadProgressBlock)progress
              success:(JQImageDownloadSuccessBlock)success
              failure:(JQImageDownloadFailureBlock)failure {

    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage options:SDWebImageLowPriority | SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        progress(receivedSize * 100.0 / expectedSize);
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            failure(error);
        } else {
            self.image = image;
            success(cacheType, image);
        }
    }];
}

@end
