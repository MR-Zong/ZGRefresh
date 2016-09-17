//
//  ZGRefreshFooterView.m
//  ZGRefresh
//
//  Created by Zong on 16/3/8.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGRefreshFooterView.h"
#import "ZGRefreshFooterDefaultView.h"

@interface ZGRefreshFooterView ()



@end

@implementation ZGRefreshFooterView

+ (instancetype)refreshFooterViewWithTarget:(id)target action:(SEL)action style:(ZGRefreshFooterViewStyle)style
{
    ZGRefreshFooterView *footerView = nil;
    switch (style) {
        case ZGRefreshFooterViewStyleDefault:
            footerView = [[ZGRefreshFooterDefaultView alloc] initWithTarget:target action:action];
            break;
            
        default:
            break;
    }
    return footerView;
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
    
    [_scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentSize"];
     [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
}

- (void)endRefresh
{
    self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, 0, self.scrollView.contentInset.right);
}

@end
