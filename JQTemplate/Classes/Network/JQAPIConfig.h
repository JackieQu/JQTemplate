//
//  JQAPIConfig.h
//  JQTemplate
//
//  Created by JackieQu on 2023/8/21.
//

#ifndef JQAPIConfig_h
#define JQAPIConfig_h

/*
 http://restapi.ele.me/v3/restaurants?extras[]=food_activity&extras[]=restaurant_activity&full_image_path=1&geohash=wx4u14w0649y&limit=20&offset=20&type=geohash
 
 http://restapi.ele.me/v3/ 请求基址
 restaurants               请求路径
 extras[]=food_activity
 extras[]=restaurant_activity
 full_image_path=1
 geohash=wx4u14w0649y
 limit=20                  返回数据数量
 offset=20                 信息查找位置的偏移量
 type=geohash              其他参数
 */

/********** SERVER HOST **********/
#define SERVER_HOST @"http://restapi.ele.me/v3/"

/********** SERVER API **********/
#define API_GetRestaurantList @"restaurants"

#endif /* JQAPIConfig_h */
