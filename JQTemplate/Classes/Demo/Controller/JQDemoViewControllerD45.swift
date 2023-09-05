//
//  JQDemoViewControllerD45.swift
//  JQTemplate
//
//  Created by JackieQu on 2023/9/4.
//

/*
 输出
 OC    用 NSLog 输出日志，语句结束需要加 ;
 Swift 用 print 输出时日，语句结束无需加 ;
 */

import UIKit

class JQDemoViewControllerD45: JQBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.test()
    }
    

    // 常量与变量
    func test() -> Void {
        /*
         常量与变量
         
         OC    定义常量 const int c = 10;
         Swift 定义常量 let c = 10
         
         OC    定义变量 int v = 10;
         Swift 定义常量 var v:Int = 10
         
         先确定类型，再赋值
         
         let f:Float = 12.3  // 表示 32 位浮点型
         let d:Double = 23.4 // 表示 64 位浮点型
         
         Swift 类型的长度比 OC 更精确
         
         let intV1 : Int
         let intV2 : Int16
         let intV3 : Int32
         let intV4 : Int64
         
         let unitV : UInt
         
         Swift 是类型安全的语言，若直接赋值错误，则直接报错，OC 不会
         let unitV : UInt = -10
         
         Swift 不允许隐式转换，但可显示转换
         var a:Int = 10
         var b:Float = Float(a)
         */
        var a:Int
        a = 10
        print(a)
        
        let b:Float = Float(a)
        print(b)
    }

    // 运算符
    func test2() -> Void {
        /*
         运算符：+、-、*、/、%、++、--，除取模运算符，其他用法同 OC 相同
         
         可以检测
         var num:UInt8 = 255 + 1
         
         不可检测
         var num1:UInt8 = 255
         var num2:UInt8 = num1 + 1
         
         Swift 类型安全，运算时应保证类型一致
         let a:Int = 10
         let b:Float = 12.3
         let c:Float = Float(a) + b
         print(c)
         
         OC    取模必须是整数
         Swift 取模可以是小数
         
         Swift 不可连续赋值，但 OC 可以，num1 = num2 = 10
         var num1 = 10
         var num2 = 20
         
         范围运算符（应用场景：遍历数组）
         封闭范围运算符：包含闭包区间所有值 a...b
         半封闭范围运算符：包含头不含尾：a..<b
         for i in arr {}
         
         BOOL
         C 和 OC 并没有真正意义上的 BOOL 值
         C     中 0 为 假，非 0 为真
         OC    中 typedef signed char BOOL
         Swift 中为真正的 BOOL 值 true / false
         */
        let a:Int = 10
        let b:Float = 12.3
        let c:Float = Float(a) + b
        print(c)
        
//        for i in 1...5 {
//            print(i)
//        }
        
//        for i in 1..<5 {
//            print(i)
//        }
        
        if c > 10 {
            print(true)
        } else {
            print(false)
        }
    }

    // 分支
    func test3() -> Void {
        /*
         1、if 后的括号可省略
         2、if 后只能接 BOOL 值
         3、if 后的大括号不可省略
         
         OC 和 Swift 都有三目运算符，用法相同
         let num = true ? 10 : 20
         print(num)
         
         循环
         Swift 和 OC 的循环大致相同，但 Swift 中 for 后的括号可以省略，while 后的括号同理，只能是 BOOL 值作为条件语句
         
         Swift 中不用定义 idx 的类型为常量还是变量
         for idx in 0...9 {
            print(idx)
         }
         
         OC 中 do - while 循环
         do {
            index --;
         } while (index > 0)
         
         Swift 中 do 用于捕获异常
         repeat {
            index = index - 1
            print(index)
         } while (index > 5)
         */
        let a = 1.0
        let b = 2.0
        if a > b {
            print("a > b")
        } else if a == b {
            print("a = b")
        } else {
            print("a < b")
        }
        
        let num = true ? 10 : 20
        print(num)
        
        var index = 10
//        while index > 5 {
//            index = index - 1
//            print(index)
//        }
        
        repeat {
            index = index - 1
            print(index)
        } while (index > 5)
    }

    // 元组
    func test4() -> Void {
        /*
         多个相同或不同类型的值的集合（用括号括起来）即元组
         元组和结构体很像，实际上是复合类型，括号内可以写任何类型，若不定义类型，则可以根据数据自动判断推算出类型
         */
        // 省略了类型
        let person = ("Jackie", 24, 185)
        print(person)
        
        // 未省略类型
        let person2:(String, Int, Double) = ("Jackie", 24, 185)
        print(person2)
        
        // 获取元组中元素
        print(person.0, person.1, person.2)
        
        // 以上元组定义方式有很大的缺陷，可读性极差
        
        // 省略
        let person3 = (name:"Jackie", age:24, height:185.0)
        print(person3)
        
        // 未省略
        let person4:(name:String, age:Int, height:Double) = (name:"Jackie", age:24, height:185.0)
        print(person4)
        
        // 获取元素
        print(person3.name, person3.age, person3.height)
        
        // 其他写法
        let (name, age, height) = (name:"Jackie", age:24, height:185.0)
        print(name, age, height)
    }
    
    // 可选值
    func test5() -> Void {
        /*
         Swift 中 nil 和 OC 中有些差异，OC 中只有对象可以用 nil，Swift 中基础类型（整型、浮点型）无值时也是 nil
         当初始化时，Swift 可以没有初始值，即产生了可选值 Optional
         
         定义可选值只需在类型后加上 ?，如：var value:Int?
         
         一个 Optional 值和非 Optional 值的区别：
         Optional 值未经初始化虽然为 nil，但普通变量连 nil 都没有
         
         提取可选类型的值（强制解析）
         Optional 值不能被直接使用，因为可选值有两种状态，分别为有值和无值，所以我们需要告诉编译器是否有值
         
         强制解析可选类型的值，只需在变量后加 !
         
         var f:Float?
         var f2:Float = value!
         print(value2)
         
         注意：如果 value 无值，运行时会报错
         
         */
//        var value:Int?
//        print(value)    // nil
        
//        var value:Int
//        print(value)    // 直接报错
        
        let value:Int? = 10
        
        if let tmpValue = value {
            
            print(tmpValue)
            
            let result:Int = value!
            print(value ?? 0)
            print(result)
        }
        
        // 当不确定可选值是否有值时，尽量使用 if 进行判断
        let url = NSURL(string: "www.baidu.com")
        if let tmpUrl = url {
            _ = NSURLRequest(url: tmpUrl as URL)
        }
        
        // 可选项：??，可以对 nil 进行快速判断，?? 后的值参与计算
        var num:Int?
        num = 123
        let result:Int = num!
        print(result)
    }
    
    func testString() -> Void {
     
        /*
         定义字符
         OC:    char charValue = 'a';
         Swift: var charValue:Character = "a"
         
         Unicode 国际标准的文本编码，几乎可以表示所有国家的字符
         OC 可以存储 ASCII 码
         Swift 可以存储 ASCII + Unicode
         
         var charValue1:Character = "🍎"        // 正确
         var charValue1:Character = "J"         // 正确
         var charValue1:Character = "Jackie"    // 错误
         
         字符串是可以存放多个字符的集合
         OC:    NSString * strValue = @"Jackie";
         Swift: let strValue:String = "Jackie"
         
         OC 是以 '\0' 为字符串结束：NSString * stringValue = @"aaaa\0bbbb";
         Swift 不是以 '\0' 为结束：let stringValue:String = "aaaa\0bbbb"
         */
        // String -> NSString
        let str:NSString = NSString(string: "Jackie")
        print(str)
        
        // 常用方法
        // 1、初始化空字符串
        let emptyString = ""
        _ = String()
        
        // 2、遍历字符串
        let str2 = "Jackie"
        for c in str2 {
            print(c)
        }
        
        // 3、获取字符串长度
        let len = str2.count
        print(len)
        
        // 4、判断字符串是否为空
        if emptyString.isEmpty {
            print("yes")
        }
        
        // 5、字符串拼接
        let string1 = "Jackie"
        let string2 = "Qu"
        let string3 = string1 + string2
        
        var string4 = "Hello"
        string4 = string4 + " " + string3
        print(string4)
        
        // 6、格式化字符串
        let strValue = "衬衫"
        let intValue = 100
        print("\(strValue)的价格是 \(intValue) 元")
        
        let pi = 3.1415926
        print(String(format: "%.2f", pi))
        
        // 7、字符串比较（和 C 语言 strcmp 相同）
        let s1 = "a"
        let s2 = "ab"
        
        if s1 > s2 {
            print("s1 > s2")
        } else if s1 < s2 {
            print("s1 < s2")
        }
        
        // 8、前后缀
        let s3 = "www.baidu.com"
        print(s3.hasPrefix("www") ? "yes" : "no")
        print(s3.hasSuffix("doc") ? "yes" : "no")
        
        // 9、大小写
        let s4 = s3.uppercased()
        let s5 = s4.lowercased()
        print(s4,s5)
        
        // 10、String 转基本数据类型
        let s6 = "44.5"
        let num = Float(s6)
        print(num!)
        
        // 11、截取字符串
        let s7 = "大鹏一日同风起，扶摇直上九万里"
        let startStr = s7.prefix(2)
        let endStr = s7.suffix(3)
        print(startStr,endStr)
        
        let startIdx = s7.index(s7.startIndex, offsetBy: 4)
        let endIdx = s7.index(s7.endIndex, offsetBy: -5)
        let s8 = s7[startIdx..<endIdx]
        print(s8)

        let s9 = (s7 as NSString).substring(to: 2)      // 0 - n
        print(s9)
        
        let s10 = (s7 as NSString).substring(from: 2)   // n - 尾
        print(s10)
        
        let range = NSRange(location:8, length: 2)
        let s11 = (s7 as NSString).substring(with: range)
        print(s11)
        
        print("StringExercise")
    }

    func testArray() -> Void {
        
        /*
         OC 只能存放对象
         Swift 既能存放对象，又能存放 Int、Float 等基本数据类型
         */
        
        // 空数组
//        let arr:[Int] = []
//        let arr2 = [Int]()
//        let arr3 = Array<Int>()
        
        // 有值数组
//        let arr4 = [1,2,3,4,5]
//        let arr5:[Int] = [6,7,8,9,10]
        let arr6:Array<Int> = [11,12,13,14,15]
        
        // 取值
        print(arr6[1])
        
        // 取值区间
        print(arr6[0..<2])
        
        // let 创建的为不可变数组
        // var 创建的为可变数组
        var arr7:[Int] = []
        arr7.append(10)
        print(arr7)
        
        // 若定义数组类型，则所有元素一定为该类型
        let arr8:[String] = ["abc","xyz"]
        print(arr8)
        
        // 若未定义数组类型，则所有元素类型为 [NSObject]
        let arr9 = ["Jackie",24,185] as [Any]
        print(arr9)
        
        // 数组元素数量
        print(arr9.count)
        
        // Any 可以存放任何的对象 func
        // AnyObject 可以存放任何 class 类型对象
        var arr10:[Any] = ["Jackie",24,185]
        print(arr10)
        
        // 合并数组
        print(arr9 + arr10)
        
        // 插入、更新元素
        arr10.insert("programmer", at: 1)
        arr10[0] = "Jack"
        print(arr10)
        
        // 删除元素
//        arr10.removeFirst()
//        arr10.removeFirst(2)
//        arr10.removeLast()
//        arr10.removeSubrange(0...2)
        
        // 删除所有，包括删除容量
//        arr10.removeAll()
//        print(arr10, "Capacity: \(arr10.capacity)")
        
        // 删除所以，不包括删除容量
//        arr10.removeAll(keepingCapacity: true)
//        print(arr10, "Capacity: \(arr10.capacity)")
        
        // 批量操作
        var arr11 = [1,2,3,4]
        // arr11[0],arr11[1] 替换为 [10,20,30,40]
        arr11[0...1] = [10,20,30,40]
        print(arr11)
        
        // 遍历操作
        for obj in arr11[0...3] {
            print(obj)
        }
        
        print("ArrayExercise")
    }
    
    func testDictionary() -> Void {
        /*
         key: key 值一定是 hash 的，一定是独一无二的，Swift 的基本数据类型（String、Int、Float）都是可哈希的，所以都可以作为 key 值
         value: 无要求
         */
        
        // 创建字典
//        let dict = ["name":"Jackie", "age":24, "height":185] as [String : Any]
//        let dict2:[String:Any] = ["name":"Jackie", "age":24, "height":185]
//        let dict3:Dictionary<String,Any> = ["name":"Jackie", "age":24, "height":185]
        
        // 创建空字典
//        let dict4:[String:Any] = [:]
//        let dict5:[String:Any] = Dictionary()

        // 可变字典
        var dict6:[String:Any] = ["name":"Jackie", "age":24, "height":185]
        // 取值
        print(dict6["name"]!)
        
        // 若 key 已存在，则更新 value，若不存在，则添加新键值对
        dict6["name"] = "Jack"
        dict6["weight"] = 80
        print(dict6)
        
        // 若 key 存在，则返回之前 key 对应的 value 值，若 key 不存在，则返回 nil
        if let tmpValue = dict6.updateValue("programmer", forKey: "name") {
            print("tmpValue: \(tmpValue)")
        }
        
        // 删除字典元素
//        dict6.removeValue(forKey: "name")
        // 删除全部元素
//        dict6.removeAll()
//        dict6.removeAll(keepingCapacity: true)
//        print(dict6,"Capacity: \(dict6.capacity)")
        
        // 遍历字典
//        for (key,value) in dict6 {
//            print("key:\(key) value:\(value)")
//        }

//        for key in dict6.keys {
//            print("key:\(key)")
//        }
        
//        for value in dict6.values {
//            print("value:\(value)")
//        }
        
        // 合并字典
        let newDict = ["hometown":"Harbin"]
        for (key,value) in newDict {
            dict6.updateValue(value, forKey: key)
        }
        print(dict6)
        
        print("DictExercise")
    }
    
    func testSwitch() -> Void {
        /*
         OC 中若不加 break 会导致 case 穿透，需要写大括号限制作用域
         Swift 中不加 break 也不会导穿透，无需写大括号限制作用域

         */
        let name = "Jackie"
        
        // 若想要穿透需要加关键字 fallthrough
        switch name {
        case "Jackie":
            print("Jackie")
//            fallthrough
        case "Jack":
            print("Jack")
        default:
            print("default")
        }
        
        // 若没有提供所有选择情况，则必须写 default
        let flag = true
        
        switch flag {
        case true:
            print("yes")
        case false:
            print("no")
        }
        
        // 区间匹配
//        let score = 85
//
//        switch score {
//        case 90...100:
//            print("A+")
//        case 80...90:
//            print("A")
//        case 70...80:
//            print("B")
//        case 60...70:
//            print("C")
//        default:
//            print("D")
//        }
        
        // switch 和 元组
//        let position = (10,10)

//        switch position {
//        case (0,0):
//            print("原点")
//        case (_,0):
//            print("X 轴")
//        case (0,_):
//            print("Y 轴")
//        case (0...,0...):
//            print("第一象限")
//        default:
//            print("其他象限")
//        }
        
        // Value Binding: 将元素中元素提取出来，直接使用，不可与 fallthrought 同用
//        switch position {
//        case (let x, 10):
//            print("x: \(x)")
////            fallthrough
//        case (1, let y):
//            print("y: \(y)")
////            fallthrough
//        case (let x, let y):
//            print("x: \(x) y: \(y)")
//        }
        
        // where 后缀的表达式为真，case 即为真
//        let point = (10, 20)
//
//        switch point {
//        case let(x,y) where x > y:
//            print("x: \(x) y: \(y)")
//        default:
//            print("other")
//        }
        
        print("SwitchExercise")
    }
    
    // 无参数无返回值
    func testFunction() -> Void {
        
        print("FuncExercise")
    }
    
    // 返回值为空时可以省略 Void
    func talk() {
        
        print("Hello")
    }
    
    // 有参数无返回值
    func talkWithName(name:String) {
        
        print("Hello \(name)")
    }
    
    // 无参数有返回值
    func show() -> Int {
        
        return 10
    }
    
    // 有参数有返回值
    func show(num:Int) -> Int {
        
        return num
    }
    
    // name1 函数的内部参数，默认情况下的参数都是内部参数
    // name2 函数的外部参数，当函数需要多个参数时，开发者并不了解每个参数的实际含义，用外部参数提示
    // age 即是外部参数，又是内部参数
    func show(name2 name1:String, age age1:Int) {
        
        print("name1: \(name1) age1: \(age1)")
    }
    
    // 默认参数，默认情况下函数参数是常量
    func showDefault(name:String, age:Int = 20) {}

    // 有 inout 修饰，传递地址
    func showNum(num:inout Int) {
        
        print("num \(num)")
        num += 1
    }
    
    // 可选参数，可变参数
    func sum(numbers:Float ...) -> Float {
        
        var result:Float = 0
        for number in numbers {
            result += number
        }
        return result
    }
    
    /*
     函数类型：
     类似于 C 语言中的函数指针，类似于 OC 中的 block
     函数类型是由参数类型和返回值组成的，每个函数都有自己的特定类型
     */
    
    // 函数类型为 () -> ()
    func myPrint() {
        print("Hello")
    }
    
    // 函数类型为 (Int,Int) -> Int
    func addition(num1:Int, num2:Int) -> Int {
        return num1 + num2
    }
    
    func subtraction(num1:Int, num2:Int) -> Int {
        return num1 - num2
    }
    
    // 函数类型作为参数传递
    func calculate(num1:Int, num2:Int, method:((Int,Int) -> Int)) -> Int {
        
        return method(num1, num2)
    }
    
    // 函数类型作为返回值传递
    /*
    func max(a:Int, b:Int) -> Int {
        
        return a > b ? a : b
    }
    
    func min(a:Int, b:Int) -> Int {
        
        return a < b ? a : b
    }
    
    func choose(getMaxNum:Bool) -> (Int,Int) -> Int {

        return getMaxNum ? max : min
    }
     */
    
    // 嵌套函数，可以隐藏内部函数
    func choose(getMaxNum:Bool) -> (Int,Int) -> Int {
        
        func max(a:Int, b:Int) -> Int {
            
            return a > b ? a : b
        }
        
        func min(a:Int, b:Int) -> Int {
            
            return a < b ? a : b
        }
        
        return getMaxNum ? max : min
    }
}
