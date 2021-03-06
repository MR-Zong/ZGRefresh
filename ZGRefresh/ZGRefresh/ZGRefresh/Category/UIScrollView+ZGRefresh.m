//
//  UITableView+ZGRefresh.m
//  ZGRefresh
//
//  Created by Zong on 16/3/7.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "UIScrollView+ZGRefresh.h"
#import <objc/runtime.h>
#import "ZGRefreshFooterView.h"
#import "ZGRefreshHeaderView.h"


static char * const kRefreshHeaderView = "zgRefreshHeaderView";
static char * const kRefreshFooterView = "zgRefreshFooterView";

@implementation UIScrollView (ZGRefresh)

- (ZGRefreshHeaderView *)zgRefreshHeaderView
{
    return objc_getAssociatedObject(self, kRefreshHeaderView);
}


- (void)setZgRefreshHeaderView:(ZGRefreshHeaderView *)zgRefreshHeaderView
{
    zgRefreshHeaderView.frame = CGRectMake(0, -100, self.bounds.size.width, 100);
    zgRefreshHeaderView.scrollView = self;
    
    objc_setAssociatedObject(self, kRefreshHeaderView, zgRefreshHeaderView, OBJC_ASSOCIATION_RETAIN);
    
    [self addSubview:zgRefreshHeaderView];

}

- (ZGRefreshFooterView *)zgRefreshFooterView
{
    return objc_getAssociatedObject(self, kRefreshFooterView);
}


- (void)setZgRefreshFooterView:(ZGRefreshFooterView *)zgRefreshFooterView
{
    zgRefreshFooterView.scrollView = self;
    objc_setAssociatedObject(self, kRefreshFooterView, zgRefreshFooterView, OBJC_ASSOCIATION_RETAIN);
    
    [self addSubview:zgRefreshFooterView];

}




// 类目最好不要重写super 的方法，因为不能调用super xxx的，这样会发生很多不可预料的问题
// 其实是分类重写系统已经有的方法会，覆盖系统原来的方法实现，
// 如果原来的方法有特别要处理的东西，那被覆盖了就没了
// 所以分类一般都是拓展，就是增加系统原来没有的方法
//- (void)setContentSize:(CGSize)contentSize
//{
//    [super setContentSize:contentSize];
//     self.refreshFooterView.frame = CGRectMake(0, self.contentSize.height, self.bounds.size.height, 100);
//}


@end
