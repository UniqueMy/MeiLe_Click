//
//  XMGInfiniteScrollView.m
//  UIScrollView -- Four
//
//  Created by 盛浩 on 2017/2/24.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "XMGInfiniteScrollView.h"

@interface XMGInfiniteScrollView() <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation XMGInfiniteScrollView

static NSUInteger const XMGImageViewCount = 3;


#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame

{
    
    if (self = [super initWithFrame:frame]) {
        
        // 创建并添加scrollView对象
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        
        scrollView.backgroundColor = [UIColor redColor];
        
        scrollView.showsVerticalScrollIndicator = NO; // 隐藏垂直滚动条
        
        scrollView.showsHorizontalScrollIndicator = NO;  // 隐藏水平滚动条
        
        scrollView.pagingEnabled = YES;  // 分页
        
        scrollView.delegate = self; // 代理
        
        [self addSubview:scrollView];
        
        self.scrollView = scrollView;
        
        self.scrollView.bounces = NO;
        
        
        
        // 创建3个UIImageView对象
        
        for (NSUInteger i = 0; i < XMGImageViewCount; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            
            [scrollView addSubview:imageView];
            
        }
        
        
        
        // 创建pageControl对象
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        
        pageControl.backgroundColor = [UIColor blueColor];
        
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
    
    // 设置pageControl的frame
    
    CGFloat pageControlW = 100;
    
    CGFloat pageControlH = 30;
    
    CGFloat pageControlX = self.bounds.size.width - pageControlW;
    
    CGFloat pageControlY = self.bounds.size.height - pageControlH;
    
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    // 设置3个UIImageView的frame
    
    CGFloat imageW = self.scrollView.frame.size.width;
    
    CGFloat imageH = self.scrollView.frame.size.height;
    
    for (NSUInteger i = 0; i < XMGImageViewCount; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        
        CGFloat imageX = i * imageW;
        
        CGFloat imageY = 0;
        
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        
    }
    
    self.scrollView.contentSize = CGSizeMake(XMGImageViewCount * imageW, 0);

    // 更新UIImageView内容
    
    [self updateContent];
    
}

#pragma mark - 属性setter
- (void)setImageNames:(NSArray *)imageNames {
    
    _imageNames = imageNames;
    // 设置总页码
    self.pageControl.numberOfPages = imageNames.count;
    
}

#pragma mark - 其他方法
- (void)updateContent {
    
    // 1.从左到右重新设置每一个UIImageView的图片
    
    for (NSUInteger i = 0; i < XMGImageViewCount; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
    
        // 求出i位置imageView对应的图片索引
        
        NSInteger imageIndex = 0; // 这里的imageIndex不能用NSUInteger
        
        if (i == 0) { // 当前页码 - 1
            
            imageIndex = self.pageControl.currentPage - 1;
            
        } else if (i == 2) { // 当前页码 + 1
            
            imageIndex = self.pageControl.currentPage + 1;
            
        } else { // // 当前页码
            
            imageIndex = self.pageControl.currentPage;
            
        }
        // 判断越界
        
        if (imageIndex == -1) { // 最后一张图片
            
            imageIndex = self.imageNames.count - 1;
            
        } else if (imageIndex == self.imageNames.count) { // 最前面那张
            
            imageIndex = 0;
            
        }
        
        imageView.image = [UIImage imageNamed:self.imageNames[imageIndex]];
        
        
        
        // 绑定图片索引到UIImageView的tag
        
        imageView.tag = imageIndex;
        
    }
    // 2.重置UIScrollView的contentOffset.width == 1倍宽度
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    
}
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // imageView的x 和 scrollView偏移量x 的最小差值
    
    CGFloat minDelta = MAXFLOAT;
    
    // 找出显示在最中间的图片索引
    
    NSInteger centerImageIndex = 0;
    
    for (NSUInteger i = 0; i < XMGImageViewCount; i++) {
        
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
- (void)startTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
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
