//
//  JQGoodsModel.m
//  JQTemplate
//
//  Created by JackieQu on 2023/6/27.
//

#import "JQGoodsModel.h"

@implementation JQGoodsModel

+ (NSArray *)loadGoodsData {

    return [JQGoodsModel modelArrayWithPath:@"mogujie"];
}

@end
