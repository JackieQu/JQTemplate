//
//  JQDemoTableModel.h
//  JQTemplate
//
//  Created by JackieQu on 2023/6/9.
//

#import "JQBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class JQDemoSectionModel, JQDemoRowModel;

@interface JQDemoTableModel : JQBaseModel

@property (nonatomic, strong) NSArray<JQDemoSectionModel *> *sections;

+ (instancetype)tableModel;

@end

@interface JQDemoSectionModel : JQBaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<JQDemoRowModel *> *rows;

@end

@interface JQDemoRowModel : JQBaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *className;
@property (nonatomic, assign) BOOL flag;

@end

NS_ASSUME_NONNULL_END
