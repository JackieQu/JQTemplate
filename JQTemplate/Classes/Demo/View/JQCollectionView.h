//
//  JQCollectionView.h
//  JQTemplate
//
//  Created by JackieQu on 2023/7/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQCollectionView : UICollectionView

+ (instancetype)collectionViewWithFrame:(CGRect)frame
                              superView:(UIView *)superView
                              imageList:(NSArray *)imageList
                           timeInterval:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
