//
//  UITableView+ZGRefresh.h
//  ZGRefresh
//
//  Created by Zong on 16/3/7.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ZGRefreshFooterView.h"
#import "ZGRefreshHeaderView.h"

@interface UIScrollView (ZGRefresh)

@property (retain, nonatomic) ZGRefreshHeaderView *refreshHeaderView;

@property (retain, nonatomic) ZGRefreshFooterView *refreshFooterView;

@end
