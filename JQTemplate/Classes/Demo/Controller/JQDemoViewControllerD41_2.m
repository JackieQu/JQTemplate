//
//  JQDemoViewControllerD41_2.m
//  JQTemplate
//
//  Created by JackieQu on 2023/9/1.
//

#import "JQDemoViewControllerD41_2.h"
//#import "JQPersonModel.h"
#import "JQPersonViewModel.h"

@interface JQDemoViewControllerD41_2 ()

//@property (nonatomic, strong) JQPersonModel *person;
@property (nonatomic, strong) JQPersonViewModel * personVM;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation JQDemoViewControllerD41_2

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    }
    return _nameLabel;
}

- (UILabel *)dateLabel {
    
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 180, 200, 50)];
    }
    return _dateLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.dateLabel];
    
    /*
//    self.person = [[Person alloc] init];
    self.person = [[JQPersonModel alloc] initWithSalutation:@"Mr" firstName:@"Jackie" lastName:@"Qu" birthDate:[NSDate date]];

    if (self.person.salutation.length > 0) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@ %@",self.person.salutation,self.person.firstName,self.person.lastName];
    } else {
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",self.person.firstName,self.person.lastName];
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE MMMM d, yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:self.person.birthDate];
     */
    
    JQPersonModel *person = [[JQPersonModel alloc] initWithSalutation:@"Mr" firstName:@"Jackie" lastName:@"Qu" birthDate:[NSDate date]];
    self.personVM = [[JQPersonViewModel alloc] initWithPerson:person];
    
    self.nameLabel.text = self.personVM.nameText;
    self.dateLabel.text = self.personVM.dateText;
}

@end
