//
//  JQDemoViewControllerD31.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/4.
//

#import "JQDemoViewControllerD31.h"
#import "JQTrainModel.h"
#import "JQTrainParser.h"

@interface JQDemoViewControllerD31 () <NSXMLParserDelegate, TrainParserDelegate>

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) JQTrainModel *train;

@property (nonatomic, strong) NSMutableString *mString;

@end

@implementation JQDemoViewControllerD31

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList= [NSMutableArray array];
    }
    return _dataList;
}

- (NSMutableString *)mString {
    
    if (!_mString) {
        _mString = [NSMutableString string];
    }
    return _mString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/train.xml"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       
        // XML 解析类
//        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
//        parser.delegate = self;
//        [parser parse];
        
        // block
//        [[JQTrainParser sharedTrainParser] getTrainListWithData:data parser:^(NSArray *trainList) {
//
//            NSLog(@"%@", trainList);
//        }];
        
        // delegate
        [[JQTrainParser sharedTrainParser] getTrainListWithData:data parserDelegate:self];
    }];
}

#pragma mark - TrainParserDelegate
- (void)trainParser:(JQTrainParser *)parser trainList:(NSArray *)trainList {
    
    NSLog(@"%@", trainList);
}

// 1. 打开文档
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
    NSLog(@"打开文档，开始解析");
    
    // 每次解析前进行清空
    [self.dataList removeAllObjects];
}

// 2. 开始查找起始标签
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    NSLog(@"开始元素 - %@",elementName);
    NSLog(@"元素属性 - %@",attributeDict);
    
    if ([elementName isEqualToString:@"trainDetailInfo"]) {
        
        self.train = [[JQTrainModel alloc] init];
        
        // 元素属性使用 KVC 进行赋值
        [self.train setValuesForKeysWithDictionary:attributeDict];
    }
    
    // 清空 mString 内容
    self.mString.string = @"";
}

// 3. 获取标签内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    // 防止多次执行获取内容的方法
    [self.mString appendString:string];
    
    NSLog(@"获取内容 - %@",string);
}

// 4. 查找结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    NSLog(@"结束元素 - %@",elementName);
    
    if ([elementName isEqualToString:@"trainDetailInfo"]) {
        
        NSLog(@"%@",self.dataList);
        
        [self.dataList addObject:self.train];
        
    } else if (![elementName isEqualToString:@"dataSet"] && ![elementName isEqualToString:@"diffgr:diffgram"]) {
        
        [self.train setValue:self.mString forKey:elementName];
    }
}

// 5. 查询文档结束
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"解析完成 - %@",self.dataList);
}

@end
