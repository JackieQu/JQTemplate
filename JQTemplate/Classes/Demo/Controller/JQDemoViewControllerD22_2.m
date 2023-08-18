//
//  JQDemoViewControllerD22_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/10.
//

#import "JQDemoViewControllerD22_2.h"
#import "JQLineLayout.h"

static NSString *identifier = @"cellID";

@interface JQDemoViewControllerD22_2 () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation JQDemoViewControllerD22_2

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
         JQLineLayout *layout = [[JQLineLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 0.618) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

@end
