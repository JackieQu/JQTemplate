//
//  JQTrainParser.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/4.
//

#import "JQTrainParser.h"
#import "JQTrainModel.h"

@interface JQTrainParser ()

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSMutableString *mString;

@property (nonatomic, strong) JQTrainModel *trainInfo;

@property (nonatomic, copy) XMLTrainParser endParser;

@property (nonatomic, weak) id<TrainParserDelegate> delegate;

@end

@implementation JQTrainParser

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (NSMutableString *)mString {
    
    if (!_mString) {
        _mString = [NSMutableString string];
    }
    return _mString;
}

// 单例
// 1. 创建静态变量
// 2. 只 alloc 一次
+ (JQTrainParser *)sharedTrainParser {
    
    static JQTrainParser *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// block
- (void)getTrainListWithData:(NSData *)data parser:(XMLTrainParser)endParser {
    
    _endParser = endParser;
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    parser.delegate = self;
    
    [parser parse];
}

// delegate
- (void)getTrainListWithData:(NSData *)data parserDelegate:(id<TrainParserDelegate>)delegate {
    
    _delegate = delegate;
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    parser.delegate = self;
    
    [parser parse];
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
        
        self.trainInfo = [[JQTrainModel alloc] init];
        
        // 元素属性使用 KVC 进行赋值
        [self.trainInfo setValuesForKeysWithDictionary:attributeDict];
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
        
        NSLog(@"%@",self.dataList.lastObject);
        
        [self.dataList addObject:self.trainInfo];
        
    } else if (![elementName isEqualToString:@"dataSet"] && ![elementName isEqualToString:@"diffgr:diffgram"]) {
        
        [self.trainInfo setValue:self.mString forKey:elementName];
    }
}

// 5. 查询文档结束
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"解析完成 - %@",self.dataList);
    
    // 解析完成后，将数据回传给视图控制器
    if (self.endParser) {
        self.endParser(self.dataList);
    }
    
    if ([self.delegate respondsToSelector:@selector(trainParser:trainList:)]) {
        [self.delegate trainParser:self trainList:self.dataList];
    }
}

@end
