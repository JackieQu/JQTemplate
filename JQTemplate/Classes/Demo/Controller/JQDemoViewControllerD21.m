//
//  JQDemoViewControllerD21.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/27.
//

#import "JQDemoViewControllerD21.h"

static NSString *cellID = @"cellID";
static NSString *headerID = @"headerID";
static CGFloat kMargin = 10.f;

@interface JQDemoViewControllerD21 () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation JQDemoViewControllerD21

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 系统自带的网格布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    NSInteger itemW = (CGRectGetWidth(self.view.frame) - kMargin * 4) / 3;
    // 设置单元格大小
    flowLayout.itemSize = CGSizeMake(itemW, itemW / 0.618);
    // 最小行间距，默认 10
    flowLayout.minimumLineSpacing = 10;
    // 最小单元格间距，默认 10
    flowLayout.minimumInteritemSpacing = 10;
    // 设置 section 内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
    // 设置滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // sectionHeader 的大小，若纵向滑动，只需设置 y 值，若横向，只需设置 x 值
    flowLayout.headerReferenceSize = CGSizeMake(0, 100);
//    flowLayout.headerReferenceSize = CGSizeMake(100, 0);
    
    // 网格视图
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.height = SCREEN_HEIGHT - STATUS_NAV_HEIGHT;
    // 设置数据源代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    // 注册 cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    // 注册 header
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    [self.view addSubview:collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 根据 id 从缓冲池中获取 cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    /*
     kind:
     UICollectionElementKindSectionHeader
     UICollectionElementKindSectionFooter
     */
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor blueColor];
        return headerView;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JQLog(@"section: %@, row: %@",@(indexPath.section),@(indexPath.row));
}

#pragma mark - UICollectionViewDelegateFlowLayout

// 设置 CGSize，代理优先级高于属性
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return CGSizeMake(20, 20);
    }
    return CGSizeMake(40, 40);
//    return CGSizeMake(arc4random_uniform(100), arc4random_uniform(100));
}

// 设置 sectionInset
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (section == 0) {
        return UIEdgeInsetsMake(20, 30, 40, 50);
    }
    return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
}

// 设置 minimumLineSpacing 最小值
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    if (section == 0) {
        return 20;
    }
    return 5;
}

// 设置 headerSize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(0, 300);
    }
    return CGSizeMake(0, 100);
}


@end
