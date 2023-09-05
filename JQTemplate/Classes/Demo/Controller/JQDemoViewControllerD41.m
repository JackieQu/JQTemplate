//
//  JQDemoViewControllerD41.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/31.
//

#import "JQDemoViewControllerD41.h"
#import "JQBookModel+CoreDataClass.h"
#import "JQReaderModel+CoreDataClass.h"

@interface JQDemoViewControllerD41 ()

@property (nonatomic, strong) NSManagedObjectContext *objContext;

@end

@implementation JQDemoViewControllerD41

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 100, 100, 40);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"select" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, 150, 100, 40);
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"update" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3= [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(50, 200, 100, 40);
    btn3.backgroundColor = [UIColor orangeColor];
    [btn3 setTitle:@"delete" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(50, 250, 100, 40);
    btn4.backgroundColor = [UIColor orangeColor];
    [btn4 setTitle:@"insert" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(insertAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    JQLog(@"%@",NSHomeDirectory());
    
    // 实例化数据库模型，合并所有模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // 实力化一个持久化调度
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 数据库地址
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(13, 1, 1) lastObject] stringByAppendingPathComponent:@"test.sqlite"];

    
    NSURL *url = [NSURL fileURLWithPath:filename];
    
    #pragma mark - 数据库迁移操作
    NSDictionary *options = @{
                               NSMigratePersistentStoresAutomaticallyOption : @YES,
                               NSInferMappingModelAutomaticallyOption : @YES
                            };
    NSError *error;
    
    // 打开数据库，若不存在则创建，创建表，若不存在则创建
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error];
    
    if (error) {
        JQLog(@"打开数据库失败：%@", error);
    } else {
        JQLog(@"打开数据库成功");
        
        // C10K
        
        // 创建操作数据库的上下文
        self.objContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        self.objContext.persistentStoreCoordinator = coordinator;
    }
}

- (void)selectAction {
    
    // 创建查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"JQReaderModel"];
    
//    request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"Jack"];
//    request.predicate = [NSPredicate predicateWithFormat:@"%K < %@",@"age",@22];
//    request.predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS %@",@"book.title",@"挪威"];
    
    // 查询数量
//    [request setFetchLimit:1];
    
    // 查询位置
//    [request setFetchOffset:1];
    
    // 获取查询数据
    NSError *error;
    
    NSArray *dataList = [self.objContext executeFetchRequest:request error:&error];
    
    if (!error) {
        
        // 懒加载，用哪个表就查哪个表
        for (JQReaderModel *r in dataList) {
            
//            JQLog(@"name: %@, age: %f, book: %@, price: %f",r.name,r.age,r.book.title,r.book.price);
            JQLog(@"name: %@, age: %f, vip: %f",r.name,r.age,r.vip);
            JQLog(@"book: %@, price: %f",r.book.title,r.book.price);
        }
    }
}

- (void)updateAction {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"JQReaderModel"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"Jack"];
    
    NSArray *dataList = [self.objContext executeFetchRequest:request error:nil];
    
    for (JQReaderModel *r in dataList) {
        
        r.name = @"Rose";
        r.age = 20;
        r.book.price = 12.3;
    }
    
    if ([self.objContext save:nil]) {
        JQLog(@"修改成功");
    } else {
        JQLog(@"修改失败");
    }
}

- (void)deleteAction {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"JQReaderModel"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"Jack"];
    
    NSArray *dataList = [self.objContext executeFetchRequest:request error:nil];
    
    for (JQReaderModel *r in dataList) {
        
        // 删除 reader
        [self.objContext deleteObject:r];
        [self.objContext deleteObject:r.book];
    }
    
    if ([self.objContext save:nil]) {
        JQLog(@"删除成功");
    } else {
        JQLog(@"删除失败");
    }
}

- (void)insertAction {
    
    /*
     打开数据库
     执行 sql 语句
     关闭数据库
     */
    
    // 准备 book 插入数据库
    JQBookModel *b = [NSEntityDescription insertNewObjectForEntityForName:@"JQBookModel" inManagedObjectContext:self.objContext];
    
    // 添加数据
    b.title = @"挪威的森林";
    b.price = 34.5;
    
    JQReaderModel *r = [NSEntityDescription insertNewObjectForEntityForName:@"JQReaderModel" inManagedObjectContext:self.objContext];
    
    r.name = @"Jackie";
    r.age = 25;
    r.vip = 1;
    r.book = b;
    
    NSError *error;
    
    // 保存数据
    if ([self.objContext save:&error]) {
        JQLog(@"插入成功");
    } else {
        JQLog(@"插入失败：%@",error);
    }
}

@end
