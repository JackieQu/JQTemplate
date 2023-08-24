//
//  JQAnnotation.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/24.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

// 定义大头针样式，必须遵守 MKAnnotation 协议
@interface JQAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@property (nonatomic, copy, nullable) NSString *icon;

@end

NS_ASSUME_NONNULL_END
