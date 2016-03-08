//
//  ZGRefreshFooterView.m
//  ZGRefresh
//
//  Created by Zong on 16/3/8.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGRefreshFooterView.h"

@implementation ZGRefreshFooterView


- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    
    [_tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)dealloc
{
    [_tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, 100);
}

@end
