//
//  JQDemoViewControllerD38.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/24.
//

#import "JQDemoViewControllerD38.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface JQDemoViewControllerD38 ()

@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation JQDemoViewControllerD38

- (CLLocationManager *)manager {
    
    if (!_manager) {
        
        _manager = [[CLLocationManager alloc] init];
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.distanceFilter = 5;
    }
    return _manager;
}

- (UITextField *)textField {
    
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
        _textField.centerX = self.view.centerX;
        _textField.backgroundColor = [UIColor lightGrayColor];
        _textField.text = @"黄浦公馆2期";
    }
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.textField];
    
    if (![CLLocationManager locationServicesEnabled]) {
        
        JQLog(@"提示用户打开定位服务");
        
    } else {
        
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        if (status == kCLAuthorizationStatusNotDetermined) {
            
            [self.manager requestWhenInUseAuthorization];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    JQLog(@"%@", self.textField.text);
    
    // 实例化编码器
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    
    [gecoder geocodeAddressString:self.textField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        JQLog(@"%@",@(placemarks.count));
        
        JQLog(@"%@",error);
        
        if (!placemarks.count || error) {
            JQLog(@"地理编码失败");
            return;
        }
        
        // 获取位置标记
        CLPlacemark *placemark = [placemarks lastObject];
        
        CLLocationCoordinate2D coorinate = placemark.location.coordinate;
        
        JQLog(@"经度: %f",coorinate.longitude);
        JQLog(@"纬度: %f",coorinate.latitude);
        
        // 导航的终点、起点的类，mapItemForCurrentLocation 获取起点的位置
        MKMapItem *sourceItem = [MKMapItem mapItemForCurrentLocation];
        
        MKPlacemark *placemark2 = [[MKPlacemark alloc] initWithCoordinate:coorinate addressDictionary:nil];
        
        MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:placemark2];
        
        destinationItem.name = self.textField.text;
        
        NSArray *items = @[sourceItem,destinationItem];
        
        /*
         MKLaunchOptionsDirectionsModeKey   出行方式
         MKLaunchOptionsMapTypeKey          地图类型
         MKLaunchOptionsShowsTrafficKey     是否显示交通
         */
        NSDictionary *options = @{
                        MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                        MKLaunchOptionsMapTypeKey:@(MKMapTypeSatellite),
                        MKLaunchOptionsShowsTrafficKey:@(1)
                        };
        // 开启系统自带地图
        [MKMapItem openMapsWithItems:items launchOptions:options];
    }];
}

@end
