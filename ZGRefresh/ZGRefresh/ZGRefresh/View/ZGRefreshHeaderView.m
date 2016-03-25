//
//  ZGRefreshHeaderView.m
//  ZGRefresh
//
//  Created by Zong on 16/3/8.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGRefreshHeaderView.h"


@interface ZGRefreshHeaderView ()

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL action;

@property (nonatomic, assign) BOOL isFreshing;


@end

@implementation ZGRefreshHeaderView

+ (instancetype)refreshHeaderViewWithTarget:(id)target action:(SEL)action
{
    ZGRefreshHeaderView *refreshHeaderView = [[self alloc] initWithTarget:target action:action];
    return refreshHeaderView;
}


- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    if (self = [super init]) {
        
        self.target = target;
        self.action = action;

    }
    return self;
}



- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSValue *value = change[@"new"];
    CGPoint contentOffset = [value CGPointValue];
    if (self.isFreshing == NO && contentOffset.y <= -self.bounds.size.height) {
        self.isFreshing = YES;
        NSLog(@"下拉刷新...");
    }else if(contentOffset.y >= 0 ){
        self.isFreshing = NO;
    }
}



@end
