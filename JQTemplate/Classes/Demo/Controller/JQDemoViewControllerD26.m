//
//  JQDemoViewControllerD26.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/14.
//

#import "JQDemoViewControllerD26.h"
#import "JQCategoryModel.h"

static NSString *identifier1 = @"category";
static NSString *identifier2 = @"subCategory";

@interface JQDemoViewControllerD26 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *categoryTableView;

@property (nonatomic, strong) UITableView *subCategoryTableView;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation JQDemoViewControllerD26

- (UITableView *)categoryTableView {
    
    if (!_categoryTableView) {
        _categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.3, SCREEN_HEIGHT - STATUS_NAV_HEIGHT - SAFE_BOTTOM) style:UITableViewStylePlain];
        _categoryTableView.dataSource = self;
        _categoryTableView.delegate = self;
        [_categoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier1];
    }
    return _categoryTableView;
}

- (UITableView *)subCategoryTableView {
    
    if (!_subCategoryTableView) {
        _subCategoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.3, 0, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT - STATUS_NAV_HEIGHT - SAFE_BOTTOM) style:UITableViewStylePlain];
        _subCategoryTableView.dataSource = self;
        _subCategoryTableView.delegate = self;
        [_subCategoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier2];
    }
    return _subCategoryTableView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = [JQCategoryModel loadCategoryData];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.view addSubview:self.categoryTableView];
//    [self.view addSubview:self.subCategoryTableView];
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.categoryTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.iconView.center = self.view.center;
    self.iconView.image = [UIImage imageNamed:@"AppIcon"];
    self.iconView.layer.cornerRadius = 20;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.userInteractionEnabled = YES;
    [self.view addSubview:self.iconView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(doAction:)];
    [self.iconView addGestureRecognizer:longPress];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.categoryTableView) {
        return self.dataList.count;
    }
    
    JQCategoryModel *category = self.dataList[self.categoryTableView.indexPathForSelectedRow.row];
    return category.subcategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        JQCategoryModel *category = self.dataList[indexPath.row];
        
        cell.textLabel.text = category.name;
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    
    JQCategoryModel *category = self.dataList[self.categoryTableView.indexPathForSelectedRow.row];
    
    cell.textLabel.text = category.subcategories[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        [self.subCategoryTableView reloadData];
    }
}

- (void)doAction:(UILongPressGestureRecognizer *)longPress {
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        if (!_isAnimating) {
            [self startAnimation];
        } else {
            [self stopAnimation];
        }
        _isAnimating = !_isAnimating;
    }
}

- (void)startAnimation {
    
    CGFloat angle = M_PI_4 * 0.2;
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.values = @[@(-angle),@(angle),@(-angle)];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 0.2;
    [self.iconView.layer addAnimation:animation forKey:@"shake"];
}

- (void)stopAnimation {
    
    [self.iconView.layer removeAnimationForKey:@"shake"];
}

@end
