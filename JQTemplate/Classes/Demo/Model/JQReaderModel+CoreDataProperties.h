//
//  JQReaderModel+CoreDataProperties.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//
//

#import "JQReaderModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface JQReaderModel (CoreDataProperties)

+ (NSFetchRequest<JQReaderModel *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, retain) JQBookModel *book;

@end

NS_ASSUME_NONNULL_END
