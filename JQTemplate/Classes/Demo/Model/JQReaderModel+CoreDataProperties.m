//
//  JQReaderModel+CoreDataProperties.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//
//

#import "JQReaderModel+CoreDataProperties.h"

@implementation JQReaderModel (CoreDataProperties)

+ (NSFetchRequest<JQReaderModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"JQReaderModel"];
}

@dynamic name;
@dynamic age;
@dynamic book;

@end
