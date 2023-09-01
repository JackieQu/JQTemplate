//
//  JQReaderModel+CoreDataProperties.h
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//
//

#import "JQReaderModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface JQReaderModel (CoreDataProperties)

+ (NSFetchRequest<JQReaderModel *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) double age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double vip;
@property (nullable, nonatomic, retain) JQBookModel *book;

@end

NS_ASSUME_NONNULL_END
