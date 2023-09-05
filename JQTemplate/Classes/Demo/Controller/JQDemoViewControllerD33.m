//
//  JQDemoViewControllerD33.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/11.
//

/*
 Base64 是一种加密方式（iOS7 之后加入系统库中）（可逆的加密）
 Base64 中的可打印字符包括字母 A-Z、a-z、数字 0-9，即共有 62 个字符，/ + 填充 =
 
 echo -n BC|base64
 
 base64 ABC -o 123.txt
 base64 -D 123.txt -o uio.txt
 */

/*
 Message Digest Algorithm - MD5（消息摘要算法第五版）为计算机安全领域广泛使用的一种散列函数，用以提供消息的完成完整性保护，它是计算机广泛使用的杂凑算法之一（又译摘要算法、哈希算法），主流编程语言普遍已有 MD5 实现
 
 MD5 算法具有以下特点：
 
 1、压缩性：任意长度数据，算出的 MD5 值的长度都是固定的
 2、容易计算：从原数据计算出 MD5 值很容易
 3、抗修改性：对原数据进行任何改动，无论改动多少，所得到的 MD5 值都有很大区别
 4、强抗碰撞：已知原数据和其 MD5 值，伪造数据（找到一个具有相同 MD5 值的数据）是非常困难
 
 MD5 的作用是让大容量信息在用数字签名软件签署私人密钥前被“压缩”成一种保密的格式（即把一个任意长度做的字节串变换成一定长读的十六进制数字串）。除 MD5 外，比较常见的还有 sha-1、RIPEMD 以及 Haval 等
 */

/*
 iCloud 钥匙串，苹果提供的密码保存解决方案（iOS7 之后）
 
 存沙盒：
 1、若手机越狱，密码容易被窃取
 2、当软件更新时，沙盒中内容是不被删除的，但卸载重装后，沙盒数据就没有了
 3、每个 APP 的沙盒式相对独立的，无法共用密码
 
 存钥匙串：
 1、苹果提供的安全方案，rsa 加密，相对安全
 2、无论软件更新或重装，密码都存在，都可以自动登录
 3、同一公司的 APP 密码是可以共用的
 */

#import "JQDemoViewControllerD33.h"
#import "NSString+Hash.h"
#import <SSKeychain/SSKeychain.h>
#import <SSZipArchive/SSZipArchive.h>

#define kLoginService @"loginService"

@interface JQDemoViewControllerD33 ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JQDemoViewControllerD33

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _imageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.imageView];
    
    [self base64Test];
//    [self md5Test];
    
    [self keyChainTest];
    
//    JQLog(@"%@",NSHomeDirectory());
    
//    [self createZipFile1];
//    [self createZipFile2];
//    [self unzipFile];
    
    // 解压缩
    [SSZipArchive unzipFileAtPath:@"/Users/JackieQu/Desktop/image.zip" toDestination:@"/Users/JackieQu/Desktop/image"];
}

- (void)base64Test {
    
    // 1. 字符串转化为 base64 字符串
    NSString *string = @"{\"result\":\"{\"authorizationNum\": \"20220711zyFp6o6gv3\",\"random\": \"\"}\",\"error\":\"\",\"message\":\"此人为非养老离退休人员和遗属供养人员无法进行待遇资格认证！\"}";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    JQLog(@"%@",base64String);
    
    // 2. 加密后的 data 转化为加密前的字符串
    // 将普通的 data 转化为加密后的 data
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    // 加密后的 data 转换为普通 data
    NSData *data2 = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
    
    NSString *string2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    JQLog(@"%@",string2);
//    return;
    
    // 3. 加密图片
    UIImage *image = [UIImage imageNamed:@"AppIcon"];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *base64ImageString = [imageData base64EncodedStringWithOptions:0];
    
    // 解密图片
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:base64ImageString options:0];
    UIImage *decodeImage = [[UIImage alloc] initWithData:decodeData];
    
    self.imageView.image = decodeImage;
}

- (void)md5Test {
    
//    NSString *password = @"123456";
//    JQLog(@"%@",password.md5String);
//    
//    // md5 + 盐
//    NSString *saltPassword = [password stringByAppendingString:@"qaz,WSX.EDC,rfv"];
//    JQLog(@"%@",saltPassword.md5String);
}

- (void)keyChainTest {

    JQLog(@"%@",NSHomeDirectory());
       
    /*
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
   
    NSString *un = [ud objectForKey:@"username"];
    NSString *pw = [ud objectForKey:@"password"];
   
    JQLog(@"%@",un);
    JQLog(@"%@",pw);
     */
   
//    for (id keychain in [SSKeychain allAccounts]) {
//        JQLog(@"%@",keychain);
//    }
   
    // 通过服务标识找到密码
    NSString *password1 = [SSKeychain passwordForService:kLoginService account:@"user01" error:NULL];
    NSString *password2 = [SSKeychain passwordForService:kLoginService account:@"user02" error:NULL];
   
    JQLog(@"%@",password1);
    JQLog(@"%@",password2);
   
    // 删除钥匙串
    [SSKeychain deletePasswordForService:kLoginService account:@"JackieQu" error:NULL];
   
    NSString *password = [SSKeychain passwordForService:kLoginService account:@"JackieQu" error:NULL];
    JQLog(@"%@",password);
    
    /*
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];

    [ud setObject:username forKey:@"username"];
    [ud setObject:password forKey:@"password"];

    [ud synchronize];
     */
    
    // service 服务标识
    [SSKeychain setPassword:@"123456" forService:kLoginService account:@"user01" error:NULL];
    [SSKeychain setPassword:@"654321" forService:kLoginService account:@"user02" error:NULL];
}

- (void)createZipFile1 {
    
    NSArray *array = @[
                        [[NSBundle mainBundle] pathForResource:@"screen01" ofType:@"png"],
                        [[NSBundle mainBundle] pathForResource:@"screen02" ofType:@"png"],
                        ];
    // 根据所有文件的地址压缩文件
    [SSZipArchive createZipFileAtPath:@"/Users/JackieQu/Desktop/image.zip" withFilesAtPaths:array];
}

- (void)createZipFile2 {
    
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"images"];
    JQLog(@"%@",path);
    // 根据目录压缩文件
    [SSZipArchive createZipFileAtPath:@"/Users/JackieQu/Desktop/image.zip" withContentsOfDirectory:path];
}

- (void)unzipFile {
    
    [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:@"http://127.0.0.1/image.zip"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];

        // unzipFileAtPath 压缩包的路径
        // toDestination 解压后的路径
        [SSZipArchive unzipFileAtPath:location.path toDestination:cachesPath];
    }];
}

@end
