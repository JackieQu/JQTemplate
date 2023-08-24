//
//  JQDemoViewControllerD37.m
//  JQTemplate
//
//  Created by JackieQu on 2023/8/24.
//

#import "JQDemoViewControllerD37.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "JQAnnotation.h"

@interface JQDemoViewControllerD37 () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation JQDemoViewControllerD37

- (MKMapView *)mapView {
    
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width * 9 / 16)];
        _mapView.delegate = self;
        /*
         设置地图类型
         MKMapTypeStandard = 0, // 标准地图 2D
         MKMapTypeSatellite,    // 卫星地图
         MKMapTypeHybrid,       // 混合地图
         */
        _mapView.mapType = MKMapTypeStandard;
        // 显示用户位置
        _mapView.showsUserLocation = YES;
    }
    return _mapView;
}

- (CLLocationManager *)manager {
    
    if (!_manager) {
        
        // 创建定位管理器
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        
        /*
         extern const CLLocationAccuracy kCLLocationAccuracyBestForNavigation API_AVAILABLE(ios(4.0), macos(10.7)); // 导航定位
         extern const CLLocationAccuracy kCLLocationAccuracyBest;   // 比较准确的定位
         extern const CLLocationAccuracy kCLLocationAccuracyNearestTenMeters;   // 精确度 10 米以内
         extern const CLLocationAccuracy kCLLocationAccuracyHundredMeters;
         extern const CLLocationAccuracy kCLLocationAccuracyKilometer;
         extern const CLLocationAccuracy kCLLocationAccuracyThreeKilometers;
         */
        
        // 定位的精度，精度越高越费电
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 定位的更新频率，单位为米
        locationManager.distanceFilter = 5;
        
        _manager = locationManager;
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self geocode];
//    [self reverseGeocode];
    
    /*
     iOS 8.0 之后开启定位
     需要执行 requestAlwaysAuthorization / requestWhenInUseAuthorization，
     还需配置 info.plist，NSLocationAlwaysUsageDescription /NSLocationWhenInUseUsageDescription
     */
    
    // 1、判断版本
//    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
//    if (systemVersion >= 8.0) {
//        [self.manager requestWhenInUseAuthorization];
//    }
    
    // 2、判断方法能否执行
//    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.manager requestWhenInUseAuthorization];
//    }
    
    // 3、判断定位服务是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        
        NSLog(@"提示用户打开定位服务");
        
    } else {
        
        // 获取当前的定位状态
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        // 如果定位状态为开启
        if (status == kCLAuthorizationStatusNotDetermined) {

            [self.manager requestWhenInUseAuthorization];   // 前端定位
//            [self.manager requestAlwaysAuthorization];  // 前端和后端定位
        }

        // 开启定位
        [self.manager startUpdatingLocation];
    }
    
    [self.view addSubview:self.mapView];
    
    // 添加大头针
    JQAnnotation *annotation1 = [[JQAnnotation alloc] init];
    annotation1.coordinate = CLLocationCoordinate2DMake(40.0836433609, 116.4130202658);
    annotation1.title = @"天通苑北";
    annotation1.subtitle = @"北京";
    annotation1.icon = @"position_hl";
    [self.mapView addAnnotation:annotation1];
    
    JQAnnotation *annotation2 = [[JQAnnotation alloc] init];
    annotation2.coordinate = CLLocationCoordinate2DMake(39.8650396825, 116.3790416972);
    annotation2.title = @"北京南站";
    annotation2.subtitle = @"北京";
    annotation2.icon = @"position_hl";
    [self.mapView addAnnotation:annotation2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (![event.allTouches.anyObject.view isEqual:self.view]) {
        return;
    }
    
    JQAnnotation *annotation = [[JQAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(45.796341, 126.507318);
    annotation.title = @"TITLE";
    annotation.subtitle = @"SUBTITLE";
    annotation.icon = @"position_hl";
    [self.mapView addAnnotation:annotation];
    return;
    
    // 获取用户所在的经纬度
    CLLocationCoordinate2D coordinate = self.mapView.userLocation.location.coordinate;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    
    // 定位可见区域
    [self.mapView setRegion:region animated:YES];
    
    NSLog(@"当前经度: %f",coordinate.longitude);
    NSLog(@"当前纬度: %f",coordinate.latitude);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        NSLog(@"恢复当前位置样式");
        return nil;
    }
    
    static NSString *identifier = @"annotationView";
    
//    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!annotationView) {
        
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
        
        // 呼出标题
        annotationView.canShowCallout = YES;
        
        // 添加自定义按钮
        annotationView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    }
    
    JQAnnotation *obj = (JQAnnotation *)annotation;
    annotationView.image = [UIImage imageNamed:obj.icon];
    return annotationView;
}

// 当添加大头针时执行
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    
    for (MKAnnotationView *view in views) {
        if ([view isKindOfClass:[MKUserLocation class]]) {
            return;
        }
        // 大头针最后停止的位置
        CGRect endFrame = view.frame;
        // 重置大头针 frame，y 坐标归零
        view.frame = CGRectMake(endFrame.origin.x, 0, endFrame.size.width, endFrame.size.height);
        // 添加动画
        [UIView animateWithDuration:0.1 animations:^{
            view.frame = endFrame;
        }];
    }
}

// 当用户位置改变时调用
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    // 获取当前用户的经纬度
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    
    // 将当前屏幕设为中心点
    [mapView setCenterCoordinate:coordinate animated:YES];
    
    // 设置屏幕显示区域的经纬跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    
    // 定位可见区域
    [mapView setRegion:region animated:YES];
}

// 可见区域改变时调用
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    /*
     typedef struct {
        CLLocationDegrees latitudeDelta;
        CLLocationDegrees longitudeDelta;
     } MKCoordinateSpan;
     
     typedef struct {
        CLLocationCoordinate2D center;
        MKCoordinateSpan span;
     } MKCoordinateRegion;
     */
    
    NSLog(@"经度: %f",mapView.region.span.longitudeDelta);
    NSLog(@"纬度: %f",mapView.region.span.latitudeDelta);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    // 当定位成功后，这个代理只需执行一次，停止位置更新
    [manager stopUpdatingLocation];
    
    // 获取定位信息
    CLLocation * location = [locations lastObject];
    // 获取经纬度
    CLLocationCoordinate2D coordiante = location.coordinate;
    
    NSLog(@"经度：%f",coordiante.longitude);
    NSLog(@"纬度：%f",coordiante.latitude);
}

// 地理编码（通过地名获得经纬度）
- (void)geocode {
    
    // 实例化编码器
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    
    // 地理编码
    [gecoder geocodeAddressString:@"凯德广场学府路店" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        NSLog(@"%@",@(placemarks.count));
        
        NSLog(@"%@",error);
        
        if (!placemarks.count || error) {
            
            NSLog(@"地理编码失败");
            
            return;
        }
        
        // 获取位置标记
        for (CLPlacemark *placemark in placemarks) {
            
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            
            NSLog(@"经度: %f",coordinate.longitude);
            NSLog(@"纬度: %f",coordinate.latitude);
            
            NSLog(@"name: %@",placemark.name);
            NSLog(@"country: %@",placemark.country);
            NSLog(@"thoroughfare: %@",placemark.thoroughfare);
        }
    }];
}

// 反地理编码（通过经纬度获得地名）
- (void)reverseGeocode {
    
    // 经度: 116.405285
    // 纬度: 39.904989
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:45.722457 longitude:126.609880];
    
    // 反地理位置编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        NSLog(@"%@",@(placemarks.count));
        
        NSLog(@"%@",error);
        
        if (!placemarks.count || error) {
            
            NSLog(@"地理编码失败");
            
            return;
        }
        
        // 获取位置标记
        for (CLPlacemark *placemark in placemarks) {
            
            NSLog(@"name: %@",placemark.name);
            NSLog(@"country: %@",placemark.country);
            NSLog(@"locality: %@",placemark.locality);
        }
    }];
}

@end
