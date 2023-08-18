//
//  JQDemoViewControllerD22.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/10.
//

#import "JQDemoViewControllerD22.h"
#import "JQCollectionView.h"

@interface JQDemoViewControllerD22 ()

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation JQDemoViewControllerD22

- (NSMutableArray *)dataList {
    
    if (!_dataList) {

        _dataList = [NSMutableArray array];
        for (NSInteger i = 1; i < 6; i ++) {
            
            NSString *imageName = [NSString stringWithFormat:@"test_%02ld.jpg", i];
            [_dataList addObject:imageName];
        }
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = width * 0.618;
    
    [JQCollectionView collectionViewWithFrame:CGRectMake(0, 0, width, height) superView:self.view imageList:self.dataList timeInterval:3];
}

@end
