//
//  JQBaseTableViewController.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/13.
//

#import "JQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *identifier = @"cell]Identifier";

@interface JQBaseTableViewController : JQBaseViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

//@required

- (NSInteger)jq_numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)jq_cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//@optional

- (NSInteger)jq_numberOfSections;
- (nullable NSString *)jq_titleForHeaderInSection:(NSInteger)section;
- (nullable NSString *)jq_titleForFooterInSection:(NSInteger)section;
- (BOOL)jq_canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)jq_canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (nullable NSArray<NSString *> *)jq_sectionIndexTitles;
- (NSInteger)jq_sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (void)jq_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)jq_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

//@optional

- (void)jq_willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)jq_willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
- (void)jq_willDisplayFooterView:(UIView *)view forSection:(NSInteger)section;
- (void)jq_didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)jq_didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
- (void)jq_didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section;
- (CGFloat)jq_heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)jq_heightForHeaderInSection:(NSInteger)section;
- (CGFloat)jq_heightForFooterInSection:(NSInteger)section;

- (nullable UIView *)jq_viewForHeaderInSection:(NSInteger)section;
- (nullable UIView *)jq_viewForFooterInSection:(NSInteger)section;

- (void)jq_accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
- (BOOL)jq_shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)jq_didHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)jq_didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath;
- (nullable NSIndexPath *)jq_willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (nullable NSIndexPath *)jq_willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)jq_didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)jq_didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
