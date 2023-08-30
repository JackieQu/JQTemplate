//
//  JQDemoViewControllerD40_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//

#import "JQDemoViewControllerD40_2.h"
#import "NSString+Extension.h"
#import <FMDB/FMDB.h>

@interface JQDemoViewControllerD40_2 ()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation JQDemoViewControllerD40_2

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    NSString *filename = [NSString cachePathWith:@"test.sqlite"];
    
    // 创建 FMDatabaseQueue 实例，不需再打开数据库
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    
    // 在多线程安全的情况下操作数据
    [self.queue inDatabase:^(FMDatabase *db) {
       
        BOOL flag = [db executeUpdate:@"create table if not exists t_account (id integer primary key autoincrement, owner text, balance real);"];
        
        if (flag) {
            NSLog(@"创建成功");
        } else {
            NSLog(@"创建失败");
        }
        
        [db close];
    }];
}

- (void)selectAction {
    
    [self.queue inDatabase:^(FMDatabase *db) {
       
        if ([db open]) {
            
            FMResultSet *rs = [db executeQuery:@"select * from t_account"];
            
            while ([rs next]) {
                
                int account_id = [rs intForColumn:@"id"];
                NSString *owner = [rs stringForColumn:@"owner"];
                CGFloat balance = [rs doubleForColumn:@"balance"];
                NSLog(@"id: %d, owner: %@, balance: %lf", account_id, owner, balance);
            }
            
            [db close];
        }
    }];
}

- (void)updateAction {
    
    // 事务的优点：储存大量数据
    [self.queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            // 添加事务操作
            [db beginTransaction];
            
            BOOL flag1 = [db executeUpdate:@"update t_account set balance = 99999 where owner = '20190001'"];
            BOOL flag2 = [db executeUpdate:@"update t_account set balance = 0 where owner = '20190002'"];
            
            if (!(flag1 & flag2)) {
                
                // 事务回滚
                [db rollback];
            }
            
            // 提交事务
            [db commit];
            
            [db close];
        }
    }];
}

- (void)deleteAction {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            BOOL flag = [db executeUpdate:@"delete from t_account"];
            
            if (flag) {
                NSLog(@"删除成功");
            } else {
                NSLog(@"删除失败");
            }
            
            [db close];
        }
    }];
}

- (void)insertAction {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            [db executeUpdate:@"insert into t_account (owner, balance) values (?, ?)", @"20190001", @1000];
            [db executeUpdate:@"insert into t_account (owner, balance) values (?, ?)", @"20190002", @6688];
            
            [db close];
        }
    }];
}

@end
