//
//  JQDemoViewControllerD17.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQDemoViewControllerD17.h"

@interface JQDemoViewControllerD17 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation JQDemoViewControllerD17

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - STATUS_NAV_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"contacts" ofType:@"plist"];
        _dataList = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
//    [self.tableView setEditing:YES animated:YES];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashAction:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)trashAction:(UIBarButtonItem *)sender {
    
    if (!self.tableView.editing) {
        [self.tableView setEditing:YES animated:YES];
        return;
    }
    
    NSArray *deleteList = [self.tableView indexPathsForSelectedRows];
    if (!deleteList.count) {
        [self.tableView setEditing:NO animated:YES];
        return;
    }
    
    NSMutableArray *deleteObjects = [NSMutableArray array];
    for (NSInteger i = 0; i < deleteList.count; i ++) {
        NSIndexPath *index = deleteList[i];
        NSString *name = self.dataList[index.row];
        [deleteObjects addObject:name];
    }
    [self.dataList removeObjectsInArray:deleteObjects];
    [self.tableView deleteRowsAtIndexPaths:deleteList withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView setEditing:NO animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifiter = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    return UITableViewCellEditingStyleDelete;
//    return UITableViewCellEditingStyleInsert;
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.dataList removeObjectAtIndex:indexPath.row];
//        [self.tableView reloadData];
        NSArray *deleteIndexs = @[indexPath];
        [tableView deleteRowsAtIndexPaths:deleteIndexs withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        [self.dataList insertObject:@"测试" atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *name = self.dataList[sourceIndexPath.row];
    [self.dataList removeObjectAtIndex:sourceIndexPath.row];
    [self.dataList insertObject:name atIndex:destinationIndexPath.row];
}

@end
