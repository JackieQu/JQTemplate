//
//  JQReaderModel+CoreDataProperties.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//
//

#import "JQReaderModel+CoreDataProperties.h"

@implementation JQReaderModel (CoreDataProperties)

+ (NSFetchRequest<JQReaderModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"JQReaderModel"];
}

@dynamic age;
@dynamic name;
@dynamic vip;
@dynamic book;

@end
