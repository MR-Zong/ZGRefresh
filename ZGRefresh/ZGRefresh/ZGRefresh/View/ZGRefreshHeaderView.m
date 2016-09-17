//
//  ZGRefreshHeaderView.m
//  ZGRefresh
//
//  Created by Zong on 16/3/8.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGRefreshHeaderView.h"
#import "ZGRefreshHeaderDefaultView.h"
#import "ZGRefreshHeaderGifView.h"


@interface ZGRefreshHeaderView () 


@end

@implementation ZGRefreshHeaderView

+ (nullable instancetype)refreshHeaderViewWithTarget:(nullable id)target action:(nullable SEL)action style:(ZGRefreshHeaderViewStyle)style
{
    ZGRefreshHeaderView *refreshHeaderView = nil;
    switch (style) {
        case ZGRefreshHeaderViewStyleDefault:
            refreshHeaderView = [[ZGRefreshHeaderDefaultView alloc] initWithTarget:target action:action];
            break;
        case ZGRefreshHeaderViewStyleGif:
            refreshHeaderView = [[ZGRefreshHeaderGifView alloc] initWithTarget:target action:action];
            break;
        default:
            break;
    }
    return refreshHeaderView;
}


- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    if (self = [super init]) {
        
        self.target = target;
        self.action = action;
        [self setupViews];

    }
    return self;
}


- (void)setupViews
{

}



- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    
    UIPanGestureRecognizer *pan = nil;
    for (UIGestureRecognizer *gesture in scrollView.gestureRecognizers) {
        
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
            pan = (UIPanGestureRecognizer *)gesture;
        }
        
    }
    
    [pan addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    return;
}



@end
