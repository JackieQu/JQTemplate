//
//  JQWaterfallLayout.h
//  JQTemplate
//
//  Created by JackieQu on 2023/7/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JQCollectionViewDelegateWaterfallLayout <NSObject>

- (CGFloat)itemHeightInCollectionView:(UICollectionView *)collectionView;

@end

@interface JQWaterfallLayout : UICollectionViewLayout <UITableViewDelegate>

@property (nonatomic, weak) id<JQCollectionViewDelegateWaterfallLayout> delegate;

@end

NS_ASSUME_NONNULL_END
