//
//  JQBookModel+CoreDataProperties.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//
//

#import "JQBookModel+CoreDataProperties.h"

@implementation JQBookModel (CoreDataProperties)

+ (NSFetchRequest<JQBookModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"JQBookModel"];
}

@dynamic price;
@dynamic title;
@dynamic reader;

@end

/*
 声明 property 属性后，两种实现 @synthesize 和 @dynamic 区别：
 
 @synthesize:
    编译期间，让编译器自动生成 getter / setter 方法
    当有自定义的存取方法时，自定义会屏蔽自动生成该方法
 
 @dynamic:
    不让编译器自动生成 getter / setter 方法
    避免编译期间产生警告，然后由自己实现存取方法，或在运行时动态创建存取方法
    主要使用在 CoreData 实现 NSManagedObject 子类时使用，由 CoreData 框架在程序运行时动态生成子类属性
 */
