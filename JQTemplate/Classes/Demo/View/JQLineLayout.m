//
//  JQLineLayout.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/10.
//

#import "JQLineLayout.h"

@implementation JQLineLayout

// 准备开始布局
- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置 itemSize
    CGFloat itemW = CGRectGetHeight(self.collectionView.frame) * 0.618;
    self.itemSize = CGSizeMake(itemW, itemW);
    
    // 设置起始位置
    CGFloat sectionInsetX = (CGRectGetWidth(self.collectionView.frame) - itemW) / 2;
    self.sectionInset = UIEdgeInsetsMake(0, sectionInsetX, 0, sectionInsetX);
}

// 返回决定 cell 样式的数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    // 计算中心点的 contentOffset
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width / 2;
    
    // 获取每个 cell 的布局属性
    for (UICollectionViewLayoutAttributes * attr in attributes) {
        
        CGFloat spacing = ABS(attr.center.x - centerX);
        
        CGFloat scale = 1 - spacing / self.collectionView.bounds.size.width;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attributes;
}

// 实时刷新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

// targetContentOffset 调整后的 contentOffset
// proposedContentOffset 滑动停止后的 contentOffset
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
 
    // 计算最终可见范围
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    
    // 获取 cell 布局属性
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centenX = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;
    
    // 获取最小间距
    CGFloat minSpacing = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes * attr in attributes) {
        
        if (ABS(minSpacing) > ABS(attr.center.x - centenX)) {
            minSpacing = attr.center.x - centenX;
        }
    }
    
    // 在原有 offSet 基础上进行微调
    return CGPointMake(proposedContentOffset.x + minSpacing, proposedContentOffset.y);
}

@end
