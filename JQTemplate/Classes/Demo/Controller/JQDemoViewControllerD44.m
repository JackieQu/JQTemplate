//
//  JQDemoViewControllerD44.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/4.
//

#import "JQDemoViewControllerD44.h"
#import <objc/runtime.h>
#import "JQPersonModel.h"
#import "NSObject+AssociatedObject.h"
#import <objc/message.h>
#import "Message.h"

@interface JQDemoViewControllerD44 ()

@end

@implementation JQDemoViewControllerD44

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 验证元类
//    [self ex_registerClassPair];
    
    // 2. 属性方法
//    [self test2];
    
    // 3. 关联属性
//    [self test3];
    
    // 4. 消息发送
//    [self test4];
    
    UILabel *label = [[UILabel alloc] init];
    NSString *str = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:17]];
    label.text = str;
    label.bounds = CGRectMake(0, 0, size.width, size.height);
    label.center = self.view.center;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
}

    // 5. MethodSwizzling
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s,%@",__FUNCTION__,[self class]);
}

- (void)test4 {
    
    JQPersonModel *person = [[JQPersonModel alloc] init];
    [person run];
    [person performSelector:@selector(run)];
    ((void(*)(id, SEL))objc_msgSend)(person, @selector(run));
    
    Message *msg = [[Message alloc] init];
    [msg sendMessage:@"test"];
}

- (void)test3 {
    
    NSObject *obj = [[NSObject alloc] init];
    
    obj.associatedObject = @{@"name": @"Jackie"};
    
    NSLog(@"%@", obj.associatedObject);
}

- (void)test2 {
    
    // 实例化对象
    JQPersonModel *person = [[JQPersonModel alloc] init];
    
    Class cls = [JQPersonModel class];
    
    /** 获取对象基本属性 **/
    // 获取类名
    NSLog(@"类名：%s",class_getName(cls));
    
    // 获取父类名
    NSLog(@"父类名：%s",class_getName(class_getSuperclass(cls)));
    
    if (class_isMetaClass(cls)) {
        NSLog(@"该类为元类");
    } else {
        NSLog(@"该类非元类");
    }
    /** 获取对象基本属性 **/
    
    NSLog(@"********************");
    
    /** 获取属性 **/
    // objc_property_t 属性
    unsigned int outCount;
    
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    
    for (int i = 0; i < outCount; i ++) {
        
        // 获取对应属性
        objc_property_t property = properties[i];
        
        // 获取属性名称
        const char *propertyName = property_getName(property);
        
        NSLog(@"%s",propertyName);
    }
    
    // 释放属性列表
    free(properties);
    
    // 获取指定属性
    objc_property_t property = class_getProperty(cls, "height");
    
    if (property != NULL) {
        
        const char *propertyName = property_getName(property);
        
        NSLog(@"获取指定属性：%s",propertyName);
        
        NSString *height = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        
        [person setValue:@"185" forKey:height];

        NSLog(@"私有属性赋值：%@",[person valueForKey:@"height"]);
    }
    /** 获取属性 **/
    
    NSLog(@"********************");
    
    /** 获取成员变量 **/
    unsigned int varsOutCount;
    Ivar *vars = class_copyIvarList(cls, &varsOutCount);
    for (int i = 0; i < varsOutCount; i ++) {
        Ivar var = vars[i];
        const char * varName = ivar_getName(var);
        NSLog(@"%s",varName);
    }
    free(vars);
    
    // 获取指定成员变量
    Ivar var = class_getInstanceVariable(cls, "_name");
    const char *varName = ivar_getName(var);
    NSLog(@"获取指定成员变量：%s",varName);
    
    NSString *name = [NSString stringWithCString:varName encoding:NSUTF8StringEncoding];
    [person setValue:@"Jackie" forKey:name];
    NSLog(@"指定成员变量赋值：%@",[person valueForKey:@"name"]);
    /** 获取成员变量 **/
    
    NSLog(@"********************");
    
    /** 获取方法 **/
    unsigned int methodOutCount;
    Method *methods = class_copyMethodList(cls, &methodOutCount);
    for (int i = 0; i < methodOutCount; i ++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSLog(@"%@",NSStringFromSelector(sel));
    }
    free(methods);
    
    // 获取类方法
    unsigned int clsMethodOutCount;
    Method *clsMethods = class_copyMethodList(object_getClass(cls), &clsMethodOutCount);
    for (int i = 0; i < clsMethodOutCount; i ++) {
        Method clsMethod = clsMethods[i];
        SEL sel = method_getName(clsMethod);
        NSLog(@"获取类方法：%@",NSStringFromSelector(sel));
    }
    free(clsMethods);
    // 获取指定类方法同理
    /** 获取方法 **/
    
    NSLog(@"********************");
    
    /** 获取协议 **/
    unsigned int protocolOutCount;
    Protocol * __unsafe_unretained *protocols = class_copyProtocolList(cls, &protocolOutCount);
    for (int i = 0; i < protocolOutCount; i ++) {
        Protocol *protocol = protocols[i];
        const char *protocolName = protocol_getName(protocol);
        NSLog(@"%s",protocolName);
    }
    free(protocols);
    /** 获取协议 **/
}

// 创建类，分析类与元类的关系
void TestMetaClass(id self, SEL _cmd) {
    
    NSLog(@"This objcet is %p", self);
    
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    
    Class currentClass = [self class];
    
    for (int i = 0; i < 4; i++) {
        
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        
        //objc_getClass 得到对象的isa指针
        //objc_getClass  isa 错误
        //object_getClass 正确的
        currentClass = object_getClass(currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}

- (void)ex_registerClassPair {
    
    // 创建一个类
    // objc_allocateClassPair(Class superclass, const name, size_t extraBytes)
    // superclass 父类的名字
    // name 类名
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    
    // 给创建的类添加方法
    // OBJC_EXPORT BOOL class_addMethod(Class cls, SEL name, IMP imp, const char * types)
    // cls 添加方法的类
    // name 方法名
    // imp 方法的指针
    // types "v@:" void id cmd
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    
    // 注册类
    objc_registerClassPair(newClass);
    
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    
    [instance performSelector:@selector(testMetaClass)];
}


@end
