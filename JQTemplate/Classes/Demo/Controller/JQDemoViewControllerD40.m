//
//  JQDemoViewControllerD40.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/30.
//

#import "JQDemoViewControllerD40.h"
#import "JQSqliteHelper.h"
#import "JQStudentModel.h"
#import "JQFMDBHelper.h"

@interface JQDemoViewControllerD40 ()

@end

@implementation JQDemoViewControllerD40

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
}

- (void)selectAction {
    
    NSArray *array = [JQFMDBHelper executeQuery:@"SELECT * FROM t_student"];
    
    NSLog(@"%@", array);
    
//    NSString *sql = @"select * from t_student";
//
//    NSArray *dataList = [JQSqliteHelper sqlite3SelectWithSql:sql];
//
//    for (JQStudentModel *s in dataList) {
//
//        NSLog(@"name = %@, age = %@", s.name, @(s.age));
//    }
}

- (void)updateAction {
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE t_student SET name = '%@' WHERE name = '%@'", @"Jack", @"Jackie"];
    
    BOOL flag = [JQFMDBHelper executeUpdate:sql];
    
    if (flag) {
        NSLog(@"修改成功");
    } else {
        NSLog(@"修改失败");
    }
    
//    NSString *sql = @"update t_student set name = 'Jack' where age = 24";
//
//    if ([JQSqliteHelper sqlite3WithSql:sql]) {
//        NSLog(@"更新成功");
//    } else {
//        NSLog(@"更新失败");
//    }
}

- (void)deleteAction {
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM t_student WHERE name = '%@'", @"Jackie"];
    
    BOOL flag = [JQFMDBHelper executeUpdate:sql];

    if (flag) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
    
//    NSString *sql = @"delete from t_student where name = 'Jackie'";
//
//    if ([JQSqliteHelper sqlite3WithSql:sql]) {
//        NSLog(@"删除成功");
//    } else {
//        NSLog(@"删除失败");
//    }
}

- (void)insertAction {
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_student (name, age) VALUES ('%@', %d);", @"Jackie", 24];
    
    BOOL flag = [JQFMDBHelper executeUpdate:sql];
    
    if (flag) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
    
//    NSString *sql = [NSString stringWithFormat:@"insert into t_student (name, age) values ('%@', %d);", @"Jackie", 24];
//
//    if ([JQSqliteHelper sqlite3WithSql:sql]) {
//        NSLog(@"插入成功");
//    } else {
//        NSLog(@"插入失败");
//    }
}

@end
