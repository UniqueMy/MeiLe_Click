//
//  WuYeTongViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/22.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "WuYeTongViewController.h"
#import "WuyetongTableViewCell.h"

#define MapHeight  215

static NSString *identifier = @"WuyetongTableViewCell";

@interface WuYeTongViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView        *tableView;
@property (nonatomic,strong) BMKMapView         *mapView;
@property (nonatomic,strong) BMKLocationService *locService;

@end

@implementation WuYeTongViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect tableFrame = CGRectMake(0, MapHeight, viewWidth, self.view.bounds.size.height - Navigation_Height - MapHeight);
    _tableView.frame  = tableFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, MapHeight)];
    _mapView.showMapScaleBar   = YES;
    _mapView.showsUserLocation = YES;
    _mapView.mapType           = BMKMapTypeStandard; // 标准地图
    _mapView.delegate          = self;
    _mapView.minZoomLevel      = 5;
    _mapView.zoomLevel         = 17;
   
    [self.view addSubview:_mapView];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.rowHeight  = 80;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.userInteractionEnabled = YES;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WuyetongTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    [self.view addSubview:_tableView];

  

}

#pragma mark - BaiduMap
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    _mapView.centerCoordinate = userLocation.location.coordinate;
//    [_mapView updateLocationData:userLocation];
   
}



#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WuyetongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
