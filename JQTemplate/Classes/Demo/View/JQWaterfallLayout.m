//
//  JQWaterfallLayout.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/11.
//

#import "JQWaterfallLayout.h"

// 列数
static NSInteger defaultColumnCount = 3;
// 行间距
static NSInteger defaultRowMargin = 10;
// 列间距
static NSInteger defaultColumnMargin = 10;
// 内边距
static UIEdgeInsets defaultEdgeInsets = {10, 10, 10, 10};

@interface JQWaterfallLayout ()

// 装载 cell 所有的布局属性
@property (nonatomic, strong) NSMutableArray *attributesList;

@property (nonatomic, strong) NSMutableArray *columnHeights;

@property (nonatomic, assign) CGFloat columnMaxHeight;

@end

@implementation JQWaterfallLayout

- (NSMutableArray *)attributesList {
    
    if (!_attributesList) {
        _attributesList = [NSMutableArray array];
    }
    return _attributesList;
}

- (NSMutableArray *)columnHeights {
    
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

// 准备布局，执行刷新操作仍会执行一次
- (void)prepareLayout {
    
    [super prepareLayout];
    
    // 这里计算瀑布流属性
    [self.columnHeights removeAllObjects];
    
    for (NSInteger i = 0; i < defaultColumnCount; i ++) {
        
        // 获取所有的默认高度
        [self.columnHeights addObject:@(defaultEdgeInsets.top)];
    }
    
    // item 总数
    [self.attributesList removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 根据 indexPath 返回布局属性
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesList addObject:attributes];
    }
}

// layout 需要的所有 cell 布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attributesList;
}

// 每个 item 的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建 UICollectionViewLayoutAttributes 布局属性
    UICollectionViewLayoutAttributes *layout = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 设置默认列数
    NSInteger column = 0;
    // 获取最小高度
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    
    for (NSInteger i = 1; i < defaultColumnCount; i ++) {
        
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            
            minColumnHeight = columnHeight;
            
            column = i;
        }
    }
    
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    CGFloat width = (collectionViewW - defaultEdgeInsets.left - defaultEdgeInsets.right - defaultColumnMargin * (defaultColumnCount - 1)) / defaultColumnCount;
    CGFloat height = 0.0;
    
    // 外部传入高度
    if ([self.delegate respondsToSelector:@selector(itemHeightInCollectionView:)]) {
        height = [self.delegate itemHeightInCollectionView:self.collectionView];
    }
    
    CGFloat x = defaultEdgeInsets.left + (width + defaultColumnMargin) * column;
    CGFloat y = minColumnHeight;
    
    if (y != defaultEdgeInsets.top) {
        y += defaultRowMargin;
    }
    
    layout.frame = CGRectMake(x, y, width, height);
    
    self.columnHeights[column] = @(CGRectGetMaxY(layout.frame));
    
    CGFloat tmpColumnMaxHeight = CGRectGetMaxY(layout.frame) + defaultEdgeInsets.bottom;
    
    if (self.columnMaxHeight < tmpColumnMaxHeight) {
        self.columnMaxHeight = tmpColumnMaxHeight;
    }
    
    return layout;
}

// 滚动区域的大小
- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(0, self.columnMaxHeight);
}

@end
