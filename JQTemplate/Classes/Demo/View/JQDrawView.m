//
//  JQDrawView.m
//  JQTemplate
//
//  Created by JackieQu on 2023/7/13.
//

#import "JQDrawView.h"
#import "JQDrawPath.h"

@interface JQDrawView ()

@property (nonatomic, strong) JQDrawPath *path;

@property (nonatomic, strong) NSMutableArray *paths;

@end

@implementation JQDrawView

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    [self.paths addObject:_image];
    
    [self setNeedsDisplay];
}

- (NSMutableArray *)paths {
    
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

// 纯代码执行的第一个方法
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

// 故事板执行的第一个方法
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setUp];
}

// 添加手势
- (void)setUp {

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    
    [self addGestureRecognizer:pan];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    // 获取当前坐标
    CGPoint curPoint = [pan locationInView:self];
    
    // 判断事件开始
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        // 创建 UIBezierPath
        _path = [JQDrawPath bezierPath];
        
        // 设置起始点
        [_path moveToPoint:curPoint];
        
        // 设置线宽、颜色
        _path.lineWidth = _lineWidth;
        _path.pathColor = _pathColor;
        
        // 存入数组
        [self.paths addObject:_path];
    }
    
    // 设置终点并连线
    [_path addLineToPoint:curPoint];
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    for (JQDrawPath *path in self.paths) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            
            UIImage *image = (UIImage *)path;
            
            [image drawInRect:rect];
            
            continue;
        }
        
        [path.pathColor set];
        
        [path stroke];
    }
}

// 清空
- (void)clear {
    
    [self.paths removeAllObjects];
    
    [self setNeedsDisplay];
}

// 撤销
- (void)withdraw {
    
    [self.paths removeLastObject];
    
    [self setNeedsDisplay];
}

@end
