//
//  JQTrainParser.h
//  JQTemplate
//
//  Created by JackieQu on 2023/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XMLTrainParser)(NSArray *trainList);

@class JQTrainParser;

@protocol TrainParserDelegate <NSObject>

- (void)trainParser:(JQTrainParser *)parser trainList:(NSArray *)trainList;

@end

@interface JQTrainParser : NSObject <NSXMLParserDelegate>

+ (JQTrainParser *)sharedTrainParser;

- (void)getTrainListWithData:(NSData *)data parser:(XMLTrainParser)endParser;

- (void)getTrainListWithData:(NSData *)data parserDelegate:(id<TrainParserDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
