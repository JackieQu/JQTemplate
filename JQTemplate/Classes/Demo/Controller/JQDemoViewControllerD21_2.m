//
//  JQDemoViewControllerD21_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/27.
//

#import "JQDemoViewControllerD21_2.h"
#import "JQGoodsModel.h"
#import "JQGoodsCell.h"

static NSString *identifier = @"JQGoodsCell";

static CGFloat kMargin = 10;

@interface JQDemoViewControllerD21_2 () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation JQDemoViewControllerD21_2


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.sectionInset = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
        
        NSInteger itemW = (self.view.bounds.size.width - kMargin * 3) / 2;
        
        flowLayout.itemSize = CGSizeMake(itemW, itemW / 0.618);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.height = SCREEN_HEIGHT - STATUS_NAV_HEIGHT;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[JQGoodsCell class] forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}

-(NSArray *)dataList {
    
    if (!_dataList) {
        
        _dataList = [JQGoodsModel loadGoodsData];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JQGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.goods = self.dataList[indexPath.row];
    
    return cell;
}

@end
