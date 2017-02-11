//
//  myAnimation.h
//  大头针相关
//
//  Created by 张艳楠 on 16/7/21.
//  Copyright © 2016年 zhang yannan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface myAnimation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
