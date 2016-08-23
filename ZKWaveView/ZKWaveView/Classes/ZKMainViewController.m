
//
//  ZKMainViewController.m
//  ZKWaveView
//
//  Created by ZK on 16/8/23.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKMainViewController.h"
#import "ZKWaveView/ZKWaveView.h"

@interface ZKMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *kCellIdentify = @"UITableViewCell";

@implementation ZKMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentify];
    _tableView.tableHeaderView = [self headerView];
}

- (UIView *)headerView
{
    UIView *headerView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, self.view.frame.size.width, 200.f}];
    headerView.backgroundColor = [UIColor redColor];
    CGFloat waveViewHeight = 5.f;
    ZKWaveView *waveView = [[ZKWaveView alloc] initWithFrame:CGRectMake(0,
                                                                        headerView.frame.size.height-waveViewHeight,
                                                                        headerView.frame.size.width,
                                                                        waveViewHeight)];
    [headerView addSubview:waveView];
    
    return headerView;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    return cell;
}

@end
