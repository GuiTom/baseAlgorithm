//
//  HomeViewController.m
//  CCKit
//
//  Created by CC on 2020/1/16.
//  Copyright © 2020 CC. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDataSource.h"
#import "BubbleSort.h"
#import "SelectSort.h"
#import "MergeSort.h"

#import "QuickSort.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *table;
@end
@implementation HomeViewController
static NSString *cellId = @"cellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
   
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.table];
}
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [HomeDataSource shareInstance].dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *cells = [[HomeDataSource shareInstance].dataSource objectAtIndex:section][@"cells"];
    
    return cells.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSDictionary *cellData = [HomeDataSource shareInstance].dataSource[indexPath.section][@"cells"][indexPath.row];
    cell.textLabel.text = cellData[@"title"];
    cell.textLabel.numberOfLines = 0;
    return cell;
}
#pragma mark UIScrollViewDelegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [UILabel new];
    NSString *headerTitle = [HomeDataSource shareInstance].dataSource[section][@"header"];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor grayColor];
    label.text = headerTitle;
    label.font = [UIFont systemFontOfSize:17];
    [label sizeToFit];
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 60.0f;
    }else {
        return 44.0f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   NSDictionary *sectiondata = [HomeDataSource shareInstance].dataSource[indexPath.section];
   NSArray *cellDatas = sectiondata[@"cells"];
   NSDictionary *cellData = cellDatas[indexPath.row];
   NSString *title = cellData[@"title"];
   NSString *header = sectiondata[@"header"];
    if([header isEqualToString:@"排序"]){
        if([title isEqualToString:@"冒泡排序"]){
            [[BubbleSort new] test];
        }else  if([title isEqualToString:@"选择排序"]){
            [[SelectSort new] test];
        }else if([title isEqualToString:@"归并排序"]){
            [[MergeSort new] test];

        }else if([title isEqualToString:@"快速排序"]){
            [[QuickSort new] test];
        }
    }
    
}


@end
