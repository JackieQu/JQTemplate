//
//  JQDemoViewControllerD2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#import "JQDemoViewControllerD2.h"
#import "JQVerticalLabel.h"

@interface JQDemoViewControllerD2 ()

@property (nonatomic, strong) UILabel *testLabel;

@property (nonatomic, strong) JQVerticalLabel *verticalLabel;

@end

@implementation JQDemoViewControllerD2

- (UILabel *)testLabel {
    
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, STATUS_NAV_HEIGHT, SCREEN_WIDTH - STANDARD_MARGIN * 2, 40)];
        _testLabel.text = @"可口可乐在乎体ABC123";
        _testLabel.font = [UIFont fontWithName:@"COCA-COLACAREFONT-TEXTLIGHT--GB1-0" size:20];
        _testLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _testLabel;
}

- (JQVerticalLabel *)verticalLabel {
    
    if (!_verticalLabel) {
        _verticalLabel = [[JQVerticalLabel alloc] initWithVerticalText:@"垂直标签" fontSize:20];
        _verticalLabel.center = self.view.center;
        _verticalLabel.backgroundColor = [UIColor orangeColor];
    }
    return _verticalLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    for (NSString *familyName in [UIFont familyNames]) {
//        JQLog(@"***** %@ *****", familyName);
//        NSArray *fontNameArr = [UIFont fontNamesForFamilyName:familyName];
//        for (NSString *fontName in fontNameArr) {
//            JQLog(@"%@", fontName);
//        }
//    }
    
    [self.view addSubview:self.testLabel];
    [self.view addSubview:self.verticalLabel];
    
    /*
    NSArray *arr = @[@"车", @"马", @"象", @"王", @"后", @"象", @"马", @"车"];
    CGFloat width = CGRectGetWidth(self.view.frame) / arr.count;
    for (int i = 0; i < arr.count; i ++) {
        for (int j = 0; j < arr.count; j ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(j * width, i * width + STATUS_NAV_HEIGHT, width, width)];
            label.backgroundColor =  (i + j) % 2 == 0 ? [UIColor whiteColor] : [UIColor lightGrayColor];
            if (i == 0 || i == 7) {
                label.text = arr[j];
            }
            if (i == 1 || i == 6) {
                label.text = @"兵";
            }
            if (i == 0 || i == 1) {
                label.textColor = [UIColor blackColor];
            }
            if (i == 6 || i == 7) {
                label.textColor = [UIColor redColor];
            }
            label.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:label];
        }
    }
     */
     
    
    /*
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, STATUS_NAV_HEIGHT, SCREEN_WIDTH - STANDARD_MARGIN * 2, 100)];
    label.backgroundColor = [UIColor yellowColor];
    label.text = @"标签属性标签属性标签属性标签属性标签属性";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor blueColor];
    label.shadowColor = [UIColor lightGrayColor];
    label.shadowOffset = CGSizeMake(5, -5);
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    label.highlightedTextColor = [UIColor redColor];
    label.highlighted = YES;
    
    label.numberOfLines = 0;
    
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.5;
    [self.view addSubview:label];
     */
    
    /*
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;
    style.paragraphSpacingBefore = 20;
    style.firstLineHeadIndent = 40;
    
    NSString *str = @"富文本属性富文本属性富文本属性富文本属性富文本属性富文本属性";
    NSDictionary *dict = @{
        NSFontAttributeName: [UIFont systemFontOfSize:20],
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: [UIColor yellowColor],
        NSBackgroundColorAttributeName: [UIColor redColor],
//        NSKernAttributeName: @5,                  // 间距
//        NSStrikethroughStyleAttributeName: @1,    // 删除线
//        NSUnderlineStyleAttributeName: @1,        // 下划线
//        NSStrokeColorAttributeName: [UIColor blackColor],
//        NSStrokeWidthAttributeName: @1,           // 描边
//        NSObliquenessAttributeName: @0.5,         // 斜体
    };
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str attributes:dict];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, STATUS_NAV_HEIGHT, SCREEN_WIDTH - STANDARD_MARGIN * 2, 100)];
    label.attributedText = attrStr;
    label.backgroundColor = [UIColor cyanColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
     */
    
    /*
    NSString *str = @"可变富文本";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range1 = {0, @"可变".length};
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range1];
    
    NSRange range2 = {@"可变".length, @"富文本".length};
    NSDictionary *dict = @{
        NSForegroundColorAttributeName: [UIColor magentaColor],
        NSBackgroundColorAttributeName: [UIColor cyanColor]
    };
    [attrStr addAttributes:dict range:range2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, STATUS_NAV_HEIGHT, SCREEN_WIDTH - STANDARD_MARGIN * 2, 100)];
    label.attributedText = attrStr;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
     */
    
    /*
    NSString *str = @"@我这是评论";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range = {0, @"@我".length};
    NSDictionary *dict = @{
        NSFontAttributeName: [UIFont systemFontOfSize:20],
        NSForegroundColorAttributeName: [UIColor randomColor],
    };
    [attrStr addAttributes:dict range:range];
    
    NSDictionary *dict2 = @{
        NSFontAttributeName: [UIFont systemFontOfSize:20],
        NSForegroundColorAttributeName: [UIColor randomColor],
    };
    
    NSString *str2 = @"这是回复";
    NSAttributedString *attStr2 = [[NSAttributedString alloc] initWithString:str2 attributes:dict2];
    [attrStr appendAttributedString:attStr2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, STATUS_NAV_HEIGHT, SCREEN_WIDTH - STANDARD_MARGIN * 2, 100)];
    label.attributedText = attrStr;
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
     */
    
    /*
    NSString *str = @"单行文本计算";
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
    CGSize size = [str sizeWithAttributes:dict];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = str;
    label.font = [UIFont systemFontOfSize:20];
    label.bounds = CGRectMake(0, 0, size.width, size.height);
    label.center = self.view.center;
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
     */
    
    /*
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;
    
    NSString *str = @"多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算";
    NSDictionary *dict = @{
        NSFontAttributeName: [UIFont systemFontOfSize:20],
        NSParagraphStyleAttributeName: style,
    };
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str attributes:dict];
    
    CGFloat width = SCREEN_WIDTH - STANDARD_MARGIN * 2;
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, size.width, size.height);
    label.center = self.view.center;
    label.backgroundColor = [UIColor yellowColor];
    label.attributedText = attrStr;
    label.numberOfLines = 0;
    [self.view addSubview:label];
     */
    
    /*
    NSString *str = @"多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算多行文本计算";
    
    // sizeThatFits
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = [UIColor greenColor];
//    label.text = str;
//    label.numberOfLines = 0;
//    CGSize size = [label sizeThatFits:CGSizeMake(SCREEN_WIDTH - STANDARD_MARGIN * 2, MAXFLOAT)];
//    label.frame = CGRectMake(STANDARD_MARGIN, STATUS_NAV_HEIGHT, size.width, size.height);
//    [self.view addSubview:label];
    
    // sizeToFit
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(STANDARD_MARGIN, STATUS_NAV_HEIGHT, SCREEN_WIDTH - STANDARD_MARGIN * 2, 0)];
    label.backgroundColor = [UIColor greenColor];
    label.text = str;
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.view addSubview:label];
     */
}

@end
