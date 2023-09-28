//
//  JQBaseTableViewController.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQBaseTableViewController.h"

@interface JQBaseTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation JQBaseTableViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;

        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
}

#pragma mark - Custom Methods

//@required

- (NSInteger)jq_numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)jq_cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

//@optional

- (NSInteger)jq_numberOfSections {
    return 1;
}

- (nullable NSString *)jq_titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (nullable NSString *)jq_titleForFooterInSection:(NSInteger)section {
    return nil;
}

- (BOOL)jq_canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)jq_canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (nullable NSArray<NSString *> *)jq_sectionIndexTitles {
    return @[];
}

- (NSInteger)jq_sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 0;
}

- (void)jq_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)jq_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

//@optional
- (void)jq_willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)jq_willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void)jq_willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void)jq_didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
}

- (void)jq_didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void)jq_didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    
}

- (CGFloat)jq_heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)jq_heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)jq_heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (nullable UIView *)jq_viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (nullable UIView *)jq_viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)jq_accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)jq_shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)jq_didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)jq_didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (nullable NSIndexPath *)jq_willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (nullable NSIndexPath *)jq_willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)jq_didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JQLogFunction;
}

- (void)jq_didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableViewDataSource Methods

//@required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_numberOfRowsInSection:)]) {
        return [self jq_numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_cellForRowAtIndexPath:)]) {
        return [self jq_cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

//@optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(jq_numberOfSections)]) {
        return [self jq_numberOfSections];
    }
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_titleForHeaderInSection:)]) {
        return [self jq_titleForHeaderInSection:section];
    }
    return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_titleForFooterInSection:)]) {
        return [self jq_titleForFooterInSection:section];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_canEditRowAtIndexPath:)]) {
        return [self jq_canEditRowAtIndexPath:indexPath];
    }
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_canMoveRowAtIndexPath:)]) {
        return [self jq_canMoveRowAtIndexPath:indexPath];
    }
    return YES;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(jq_sectionIndexTitles)]) {
        return [self jq_sectionIndexTitles];
    }
    return @[];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if ([self respondsToSelector:@selector(jq_sectionForSectionIndexTitle:atIndex:)]) {
        return [self jq_sectionForSectionIndexTitle:title atIndex:index];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_commitEditingStyle:forRowAtIndexPath:)]) {
        [self jq_commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([self respondsToSelector:@selector(jq_moveRowAtIndexPath:toIndexPath:)]) {
        [self jq_moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark - UITableViewDelegate Methods

//@optional

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_willDeselectRowAtIndexPath:)]) {
        [self jq_willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_willDisplayHeaderView:forSection:)]) {
        [self jq_willDisplayHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_willDisplayFooterView:forSection:)]) {
        [self jq_willDisplayFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    if ([self respondsToSelector:@selector(jq_didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self jq_didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_didEndDisplayingHeaderView:forSection:)]) {
        [self jq_didEndDisplayingHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_didEndDisplayingFooterView:forSection:)]) {
        [self jq_didEndDisplayingFooterView:view forSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_heightForRowAtIndexPath:)]) {
        return [self jq_heightForRowAtIndexPath:indexPath];
    }
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_heightForHeaderInSection:)]) {
        return [self jq_heightForHeaderInSection:section];
    }
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_heightForFooterInSection:)]) {
        return [self jq_heightForFooterInSection:section];
    }
    return 0.001f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_viewForHeaderInSection:)]) {
        return [self jq_viewForHeaderInSection:section];
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(jq_viewForFooterInSection:)]) {
        return [self jq_viewForFooterInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_accessoryButtonTappedForRowWithIndexPath:)]) {
        [self jq_accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_shouldHighlightRowAtIndexPath:)]) {
        return [self jq_shouldHighlightRowAtIndexPath:indexPath];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_didHighlightRowAtIndexPath:)]) {
        [self jq_didHighlightRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_didUnhighlightRowAtIndexPath:)]) {
        [self jq_didUnhighlightRowAtIndexPath:indexPath];
    }
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_willSelectRowAtIndexPath:)]) {
        return [self jq_willSelectRowAtIndexPath:indexPath];
    }
    return nil;
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_willDeselectRowAtIndexPath:)]) {
        return [self jq_willDeselectRowAtIndexPath:indexPath];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self respondsToSelector:@selector(jq_didSelectRowAtIndexPath:)]) {
        [self jq_didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(jq_didDeselectRowAtIndexPath:)]) {
        [self jq_didDeselectRowAtIndexPath:indexPath];
    }
}

@end
