//
//  JQDemoViewControllerD39_6.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/28.
//

#import "JQDemoViewControllerD39_6.h"

static NSString *identifier = @"cellID";

@interface JQDemoViewControllerD39_6 ()

@end

@implementation JQDemoViewControllerD39_6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",self.title,indexPath.row];
    
    return cell;
}

@end
