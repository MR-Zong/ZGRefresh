//
//  UITableView+ZGRefresh.m
//  ZGRefresh
//
//  Created by Zong on 16/3/7.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "UITableView+ZGRefresh.h"
#import <objc/runtime.h>


static char * const kRefreshHeaderView = "refreshHeaderView";
static char * const kRefreshFooterView = "refreshFooterView";

@implementation UITableView (ZGRefresh)

- (UIView *)refreshHeaderView
{
    return objc_getAssociatedObject(self, kRefreshHeaderView);
}

- (void)setRefreshHeaderView:(UIView *)refreshHeaderView
{
    refreshHeaderView.frame = CGRectMake(0, -100, self.bounds.size.width, 100);
    refreshHeaderView.backgroundColor = [UIColor redColor];
    
    objc_setAssociatedObject(self, kRefreshHeaderView, refreshHeaderView, OBJC_ASSOCIATION_RETAIN);
    
    [self addSubview:refreshHeaderView];
}

- (UIView *)refreshFooterView
{
    return objc_getAssociatedObject(self, kRefreshFooterView);
}

- (void)setRefreshFooterView:(UIView *)refreshFooterView
{
    refreshFooterView.backgroundColor = [UIColor blueColor];
    objc_setAssociatedObject(self, kRefreshFooterView, refreshFooterView, OBJC_ASSOCIATION_RETAIN);
    
    [self addSubview:refreshFooterView];
    
//    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

//- (void)dealloc
//{
//
//    [self removeObserver:self forKeyPath:@"contentSize"];
//}


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    self.refreshFooterView.frame = CGRectMake(0, self.contentSize.height, self.bounds.size.height, 100);
//}

// 类目最好不要重写super 的方法，因为不能调用super xxx的，这样会发生很多不可预料的问题
- (void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
     self.refreshFooterView.frame = CGRectMake(0, self.contentSize.height, self.bounds.size.height, 100);
}


@end
