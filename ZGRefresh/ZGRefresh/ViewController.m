//
//  ViewController.m
//  ZGRefresh
//
//  Created by Zong on 16/3/7.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ViewController.h"
#import "ZGRefresh.h"


@interface ViewController () <UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView = tableView;

    tableView.dataSource = self;
    
    // 设置ZGRefresh header footer
    tableView.zgRefreshHeaderView = [ZGRefreshHeaderView refreshHeaderViewWithTarget:self action:@selector(headerRefresh) style:ZGRefreshHeaderViewStyleDefault];
    tableView.zgRefreshFooterView = [ZGRefreshFooterView refreshFooterViewWithTarget:self action:@selector(footerRefresh) style:ZGRefreshFooterViewStyleDefault];
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    
    [self.tableView.zgRefreshHeaderView startRefresh];
    
}


- (void)headerRefresh
{
    // 模拟网络延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1.5), dispatch_get_main_queue(), ^{
        [self.tableView.zgRefreshHeaderView endRefresh];
        NSLog(@"从服务器获取数据 下拉");
    });
}

- (void)footerRefresh
{
    // 模拟网络延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1.5), dispatch_get_main_queue(), ^{
        [self.tableView.zgRefreshFooterView endRefresh];
        NSLog(@"从服务器获取数据 上拉");
    });

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
