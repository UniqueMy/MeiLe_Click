//
//  SHRollScrollView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/22.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "SHRollScrollView.h"

@interface SHRollScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *imageMutableArray;
@property (nonatomic,strong) UIImageView   *imgVLeft;
@property (nonatomic,strong) UIImageView   *imgVCenter;
@property (nonatomic,strong) UIImageView   *imgVRight;
@property (nonatomic,strong) UIPageControl *pageC;
@property (nonatomic,assign) NSUInteger    imageCount;
@property (nonatomic,assign) NSUInteger    currentImageIndex;

@end


@implementation SHRollScrollView
{
    CGSize viewSize;
    UIViewController *superVC;
}
- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController
{
    self = [super initWithFrame:frame];
    if (self) {
    
        viewSize = frame.size;
        superVC  = viewController;
        
        [self loadImageData];
        [self layoutUI];
        [self addImageViewToScrollView];
        [self setDefaultInfo];
        
    }
    return self;
}

- (void)loadImageData {
    
    self.backgroundColor = [UIColor orangeColor];
    
    _imageMutableArray = [NSMutableArray array];
    [_imageMutableArray addObject:@"homepage_zbg_scroll_0"];
    [_imageMutableArray addObject:@"login_submit_button"];
    
    _imageCount = _imageMutableArray.count;
    
}

- (void)layoutUI {
    
    NSInteger number = _imageCount == 1 ? 1 : 3;
    
    self.contentSize   = CGSizeMake(viewWidth * number, viewSize.height);
    self.contentOffset = CGPointMake(viewWidth, 0);
    self.bounces = NO;
    self.pagingEnabled = YES;
    self.delegate      = self;
    self.showsHorizontalScrollIndicator = NO;
    
}

- (void)addImageViewToScrollView {
    
    //图片视图；左边
    _imgVLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, viewWidth, viewSize.height)];
    _imgVLeft.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgVLeft];
    
    //图片视图；中间
    _imgVCenter = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth, 0.0, viewWidth, viewSize.height)];
    _imgVCenter.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgVCenter];
    
    //图片视图；右边
    _imgVRight = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth * 2.0, 0.0, viewWidth, viewSize.height)];
    _imgVRight.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgVRight];
    
}

- (void)addPageControl {
    _pageC = [UIPageControl new];
    CGSize size= [_pageC sizeForNumberOfPages:_imageCount]; //根据页数返回 UIPageControl 合适的大小
    _pageC.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
    _pageC.center = CGPointMake(viewWidth / 2.0, viewSize.height - 8.0);
    _pageC.numberOfPages = _imageCount;
    _pageC.pageIndicatorTintColor = [UIColor lightGrayColor];
    //设置选中页码点的颜色
    _pageC.currentPageIndicatorTintColor = [UIColor whiteColor];
     // 设置是否允许用户交互；默认值为 YES，当为 YES 时，针对点击控件区域左（当前页索引减一，最小为0）右（当前页索引加一，最大为总数减一），可以编写 UIControlEventValueChanged 的事件处理方法
    _pageC.userInteractionEnabled = NO;
//    _pageC.currentPage = 0;
    [superVC.view addSubview:_pageC];
    
}
- (void)setDefaultInfo {
    _currentImageIndex = 0;
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}

- (void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex {
    
    _imgVCenter.image = [UIImage imageNamed:_imageMutableArray[currentImageIndex]];
    _imgVLeft.image   = [UIImage imageNamed:_imageMutableArray[((_currentImageIndex - 1 + _imageCount) % _imageCount)]];
    _imgVRight.image  = [UIImage imageNamed:_imageMutableArray[((_currentImageIndex + 1) % _imageCount)]];

    _pageC.currentPage = currentImageIndex;
}

- (void)reloadImage {
    
    CGPoint contentOffset = [self contentOffset];
    if (contentOffset.x > viewWidth) { //向左滑动
        _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
        
    } else if (contentOffset.x < viewWidth) { //向右滑动
        _currentImageIndex = (_currentImageIndex - 1 + _imageCount) % _imageCount;
    }
   
    [self setInfoByCurrentImageIndex:_currentImageIndex];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImage];
    
    self.contentOffset = CGPointMake(viewWidth, 0.0);
    _pageC.currentPage = _currentImageIndex;
    
}


@end
