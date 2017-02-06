//
//  changeViewController.m
//  UItest
//
//  Created by XQQ on 16/8/10.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "changeViewController.h"

#define iphoneWidth  [UIScreen mainScreen].bounds.size.width
#define iphoneHeight [UIScreen mainScreen].bounds.size.height
@interface changeViewController()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
/**
 *  tabelView
 */
@property (nonatomic, strong) UITableView * myTabelView;
/**
 *  数据源
 */
@property (nonatomic, strong)  NSMutableArray  *  dataArr;
/**
 *  tabelView头视图
 */
@property (nonatomic, strong)  UIView  *  headView;
/**
 *  记录偏移量
 */
@property(nonatomic, assign)  CGPoint   tabelViewContentOffset;
/**
 *  titleView
 */
@property(nonatomic, strong)  UIImageView  *  titleView;

@end

@implementation changeViewController

- (void)viewDidLoad
{;
    [super viewDidLoad];
   
    [self.navigationController.navigationBar addSubview:self.titleView];
    /**
     * 组织数据源
     */
    for (int i = 0; i < 20; i ++) {
        NSString * str = [NSString stringWithFormat:@"我是第%d行",i];
        [self.dataArr addObject:str];
    }
    [self.view addSubview:self.myTabelView];
    _tabelViewContentOffset = self.myTabelView.contentOffset;
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //记录初始的偏移量
  _tabelViewContentOffset = self.myTabelView.contentOffset;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //这里面拿到偏移量
    CGPoint size = self.myTabelView.contentOffset;
   
    CGFloat alphaPer = size.y/80.0 + 0.55;
   
    self.titleView.alpha = alphaPer;

    if (size.y > _tabelViewContentOffset.y) {
        //向上的
        //NSLog(@"向上的 %f",size.y);
        _tabelViewContentOffset = size;
    }else
    {
        //向下的
        //NSLog(@"向下的 %f",size.y);
        _tabelViewContentOffset = size;
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * idStr = @"isStr";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idStr];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idStr];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - setter&getter

- (UIImageView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIImageView alloc]initWithFrame:CGRectMake(iphoneWidth/2-20, 0, 40, 40)];
        _titleView.layer.cornerRadius = 20;
        _titleView.layer.masksToBounds = YES;
        _titleView.image = [UIImage imageNamed:@"2.jpg"];
        _titleView.alpha = 0;
    }
    return _titleView;
}
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iphoneWidth, 120)];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_headView.frame.size.width/2-40, 20, 80, 80)];
        
        imageView.layer.cornerRadius = 39.0;
        imageView.layer.masksToBounds = YES;
        imageView.image = [UIImage imageNamed:@"2.jpg"];
        [_headView addSubview:imageView];
    }
    return _headView;
}

- (UITableView *)myTabelView
{
    if (!_myTabelView) {
        _myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, iphoneWidth,iphoneHeight) style:UITableViewStylePlain];
        _myTabelView.delegate = self;
        _myTabelView.dataSource = self;
        _myTabelView.tableHeaderView = self.headView;
        _myTabelView.clipsToBounds = YES;
    }
    return _myTabelView;
}


- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}


@end
