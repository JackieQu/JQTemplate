//
//  JQDemoViewControllerD22_3.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/11.
//

#import "JQDemoViewControllerD22_3.h"
#import "JQWaterfallLayout.h"
#import "JQLabelCell.h"

static CGFloat kMargin = 10;

static NSString *identifier = @"cellID";

@interface JQDemoViewControllerD22_3 () <UICollectionViewDataSource, UICollectionViewDelegate, JQCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation JQDemoViewControllerD22_3

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        JQWaterfallLayout *layout = [[JQWaterfallLayout alloc] init];
        layout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.height -= TAB_BAR_HEIGHT;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[JQLabelCell class] forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
     
        _dataList = [NSMutableArray array];
        
        CGFloat width = (self.view.bounds.size.width - kMargin * 4) / 3;
        CGFloat height = 0.0;
        
        for (NSInteger i = 0; i < 20; i ++) {
            
            height = 50 + arc4random_uniform(100);
            [_dataList addObject:[NSValue valueWithCGSize:CGSizeMake(width, height)]];
        }
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    return self.dataList.count;
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JQLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.index = indexPath.row;
    
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    NSValue * value = self.dataList[indexPath.row];
//
//    NSLog(@"%@",NSStringFromCGSize([value CGSizeValue]));
//
//    return [value CGSizeValue];
//}

#pragma mark - QPCollectionViewDelegateWaterLayout

- (CGFloat)itemHeightInCollectionView:(UICollectionView *)collectionView {
    
    return 50 + arc4random_uniform(150);
}

@end
