//
//  SHRollScrollView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/24.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "SHRollScrollView.h"

@interface SHRollScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer       *timer;

@end

static NSUInteger const ImageCount = 3;

@implementation SHRollScrollView
{
    CGSize viewSize;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        viewSize = frame.size;
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsVerticalScrollIndicator  = NO; // 隐藏垂直滚动条
        scrollView.showsHorizontalScrollIndicator = NO;  // 隐藏水平滚动条
        scrollView.pagingEnabled = YES;  // 分页
        scrollView.delegate      = self; // 代理
        [self addSubview:scrollView];
        
        self.scrollView         = scrollView;
        self.scrollView.bounces = NO;
        
        // 创建3个UIImageView对象
        for (NSUInteger i = 0; i < ImageCount; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [scrollView addSubview:imageView];
            
        }
        
        // 创建pageControl对象
        UIPageControl *pageControl  = [[UIPageControl alloc] init];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 开启定时器
        [self startTimer];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // scrollView
    self.scrollView.frame = self.bounds;
    
    CGSize size= [self.pageControl sizeForNumberOfPages:ImageCount]; //根据页数返回 UIPageControl 合适的大小
    self.pageControl.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
    self.pageControl.center = CGPointMake(viewWidth / 2.0, viewSize.height - 8.0);
    
    
    // 设置3个UIImageView的frame
    CGFloat imageW = viewSize.width;
    CGFloat imageH = viewSize.height;
    
    for (NSUInteger i = 0; i < ImageCount; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat imageX  = i * imageW;
        CGFloat imageY  = 0;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
    }
    
    self.scrollView.contentSize = CGSizeMake(ImageCount * imageW, 0);
    
    // 更新UIImageView内容
    [self updateContent];
    
}

#pragma mark - 属性setter
- (void)setImageArray:(NSArray *)imageArray {
    
    _imageArray = imageArray;
    // 设置总页码
    self.pageControl.numberOfPages = imageArray.count;
    
}

#pragma mark - 其他方法
- (void)updateContent {
    
    // 1.从左到右重新设置每一个UIImageView的图片
    for (NSUInteger i = 0; i < ImageCount; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        
        // 求出i位置imageView对应的图片索引
        // 这里的imageIndex不能用NSUInteger
        NSInteger imageIndex = 0;
        
        if (i == 0) {
            
            // 当前页码 - 1
            imageIndex = self.pageControl.currentPage - 1;
            
        } else if (i == 2) {
            
            // 当前页码 + 1
            imageIndex = self.pageControl.currentPage + 1;
            
        } else {
            
            // 当前页码
            imageIndex = self.pageControl.currentPage;
            
        }
        
        // 判断越界
        if (imageIndex == -1) { // 最后一张图片
            
            imageIndex = self.imageArray.count - 1;
            
        } else if (imageIndex == self.imageArray.count) { // 最前面那张
            
            imageIndex = 0;
        }
        
        imageView.image = [UIImage imageNamed:self.imageArray[imageIndex]];
        
        // 绑定图片索引到UIImageView的tag
        imageView.tag = imageIndex;
        
    }
    
    // 2.重置UIScrollView的contentOffset.width == 1倍宽度
    self.scrollView.contentOffset = CGPointMake(viewSize.width, 0);
    
}
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // imageView的x 和 scrollView偏移量x 的最小差值
    CGFloat minDelta = MAXFLOAT;
    
    // 找出显示在最中间的图片索引
    NSInteger centerImageIndex = 0;
    
    for (NSUInteger i = 0; i < ImageCount; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        
        // ABS : 取得绝对值
        CGFloat delta = ABS(imageView.frame.origin.x - self.scrollView.contentOffset.x);
        
        if (delta < minDelta) {
            
            minDelta = delta;
            
            centerImageIndex = imageView.tag;
            
        }
    }
    // 设置页码
    self.pageControl.currentPage = centerImageIndex;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self updateContent];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self stopTimer];
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    [self startTimer];
    
}

#pragma mark - 定时器处理
// 开启定时器
- (void)startTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

// 停止定时器
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

// 显示下一页
- (void)nextPage
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(2 * self.scrollView.frame.size.width, 0);
        
    } completion:^(BOOL finished) {
        
        [self  updateContent];
        
    }];
}


@end

