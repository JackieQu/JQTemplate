//
//  JQBookModel+CoreDataProperties.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//
//

#import "JQBookModel+CoreDataProperties.h"

@implementation JQBookModel (CoreDataProperties)

+ (NSFetchRequest<JQBookModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"JQBookModel"];
}

@dynamic name;
@dynamic price;
@dynamic reader;

@end
