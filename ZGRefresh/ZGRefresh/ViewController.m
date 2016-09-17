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
    tableView.refreshHeaderView = [ZGRefreshHeaderView refreshHeaderViewWithTarget:self action:@selector(headerRefresh) style:ZGRefreshHeaderViewStyleDefault];
    tableView.refreshFooterView = [ZGRefreshFooterView refreshFooterViewWithTarget:self action:@selector(footerRefresh)];
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    
}


- (void)headerRefresh
{
    NSLog(@"从服务器获取数据 下拉");
}

- (void)footerRefresh
{
    NSLog(@"从服务器获取数据 上拉");
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
