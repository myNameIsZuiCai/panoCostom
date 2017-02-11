//
//  ViewController.m
//  大头针相关
//
//  Created by 张艳楠 on 16/7/20.
//  Copyright © 2016年 zhang yannan. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#define span MKCoordinateSpanMake(0.002703,0.001717)
@interface ViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *myMap;
@property (strong, nonatomic) CLLocationManager *manager;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myMap.delegate=self;
    self.myMap.userTrackingMode=MKUserTrackingModeFollow;
    // Do any additional setup after loading the view, typically from a nib.
    //请求授权
    self.manager=[[CLLocationManager alloc]init];
    self.myMap.mapType=MKMapTypeHybrid;
    [self.manager requestAlwaysAuthorization];
    //设置导航
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:@"河南牧业经济学院英才校区" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *pm in placemarks) {
//          NSLog(@"经度=%f,纬度=%f",[[placemarks firstObject] location].coordinate.latitude,[[placemarks firstObject] location].coordinate.longitude);
            NSLog(@"weidu=%f   jingdu=%f",[pm location].coordinate.latitude,[pm location].coordinate.longitude);
            NSLog(@"name=%@",pm.name);
        }
    }];
    //添加自定义的大头针
    myAnimation *ani1=[[myAnimation alloc]init];
    ani1.coordinate=CLLocationCoordinate2DMake(34.865204, 113.641397);
    ani1.title=@"河南牧业经济学院";
    ani1.subtitle=@"英才校区";
    
    myAnimation *ani2=[[myAnimation alloc]init];
    ani2.coordinate=CLLocationCoordinate2DMake(34.865204, 113.641398);
    ani2.title=@"河南商专";
    ani2.subtitle=@"河南商业高等专科学校";
    
    [self.myMap addAnnotation:ani1];
    [self.myMap addAnnotation:ani2];
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [self.myMap setRegion:MKCoordinateRegionMake(userLocation.location.coordinate, span) animated:YES];
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    MKCoordinateRegion region=mapView.region;
    CLLocationCoordinate2D coordinate=region.center;
    [self.myMap setRegion:MKCoordinateRegionMake(coordinate, span)];
}
//单机屏幕之后添加大头针
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1、获取用户在屏幕上的单击时的屏幕坐标点
    CGPoint point=[[touches anyObject] locationInView:self.view];
    //2、将屏幕坐标点转化为地图上的经纬度
    CLLocationCoordinate2D coordinate=[self.myMap convertPoint:point toCoordinateFromView:self.view];
    //3、添加大头针
    myAnimation *ani1=[[myAnimation alloc]init];
    ani1.coordinate=coordinate;
    ani1.title=@"";
    ani1.subtitle=@"";
    [self.myMap addAnnotation:ani1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
