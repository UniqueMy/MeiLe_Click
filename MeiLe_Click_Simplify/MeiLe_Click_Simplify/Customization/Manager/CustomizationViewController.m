//
//  CustomizationViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "CustomizationViewController.h"
#import "SHRollScrollView.h"
#define MapHeight  215

#define kWidthOfScreen  [[UIScreen mainScreen] bounds].size.width
#define kHeightOfScreen [[UIScreen mainScreen] bounds].size.height

@interface CustomizationViewController ()<UIScrollViewDelegate>


@property (nonatomic,strong) BMKMapView  *mapView;


@end

@implementation CustomizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, MapHeight)];
    _mapView.showMapScaleBar   = YES;
    _mapView.showsUserLocation = YES;
    _mapView.mapType           = BMKMapTypeStandard; // 标准地图
//    _mapView.delegate          = self;
    _mapView.minZoomLevel      = 5;
    _mapView.zoomLevel         = 17;
    [self.view addSubview:_mapView];

}


@end
