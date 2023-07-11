//
//  JQCollectionLayout.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/10.
//

#import "JQCollectionLayout.h"

@implementation JQCollectionLayout

- (instancetype)init {
    
    if (self = [super init]) {
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsZero;
    }
    return self;
}

@end
