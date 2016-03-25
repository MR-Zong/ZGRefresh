//
//  ZGRefreshFooterView.m
//  ZGRefresh
//
//  Created by Zong on 16/3/8.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGRefreshFooterView.h"

@interface ZGRefreshFooterView ()

@property (nonatomic, assign) BOOL isFreshing;

@end

@implementation ZGRefreshFooterView

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    
    [_tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)dealloc
{
    [_tableView removeObserver:self forKeyPath:@"contentSize"];
     [_tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        self.frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, 100);
        return;
    }
    
    NSValue *value = change[@"new"];
    CGPoint contentOffset = [value CGPointValue];
    if (self.isFreshing == NO && contentOffset.y >= (self.tableView.contentSize.height + self.bounds.size.height - [UIScreen mainScreen].bounds.size.height)) {
        self.isFreshing = YES;
        NSLog(@"上拉刷新...");
    }else if(contentOffset.y <= (self.tableView.contentSize.height - [UIScreen mainScreen].bounds.size.height) ){
        self.isFreshing = NO;
    }
}

@end
