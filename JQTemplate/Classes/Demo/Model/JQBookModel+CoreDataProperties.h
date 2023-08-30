//
//  JQBookModel+CoreDataProperties.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//
//

#import "JQBookModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface JQBookModel (CoreDataProperties)

+ (NSFetchRequest<JQBookModel *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSDecimalNumber *price;
@property (nullable, nonatomic, retain) JQReaderModel *reader;

@end

NS_ASSUME_NONNULL_END
