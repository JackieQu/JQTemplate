//
//  JQBookModel+CoreDataProperties.h
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//
//

#import "JQBookModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface JQBookModel (CoreDataProperties)

+ (NSFetchRequest<JQBookModel *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) double price;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) JQReaderModel *reader;

@end

NS_ASSUME_NONNULL_END
