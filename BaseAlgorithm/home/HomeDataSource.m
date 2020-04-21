
//
//  HomeDataSource.m
//  CCKit
//
//  Created by CC on 2020/1/16.
//  Copyright © 2020 CC. All rights reserved.
//
#import <objc/message.h>
#import "HomeDataSource.h"
@interface HomeDataSource()

@end
@implementation HomeDataSource
+(instancetype)shareInstance{
    static HomeDataSource * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HomeDataSource alloc] init];
    });
  
    return instance;
}
-(instancetype)init{
    if(self = [super init]){
        [self initDataSource];
    }
    return self;
}
-(void)initDataSource{
    if(!_dataSource){
        _dataSource = @[
            @{
                @"header":@"排序",
                @"cells":@[
                        @{@"title":@"冒泡排序"},
                        @{@"title":@"选择排序"},
                        @{@"title":@"归并排序"},
                        @{@"title":@"希尔排序"},
                        @{@"title":@"快速排序"},
                        @{@"title":@"堆排序"},
                        @{@"title":@"计数排序"},
                        @{@"title":@"基数排序"},
                        @{@"title":@"桶排序"}
                ],
            },@{
                @"header":@"树",
                @"cells":@[
                        @{@"title":@"AVL树"},
                        @{@"title":@"B树"},
                        @{@"title":@"红黑树"},
                        @{@"title":@"B+树"}
                ],
            },
            @{
                @"header":@"字符串查找",
                 @"cells":@[
                         @{@"title":@"kmp"},
                         @{@"title":@"BM"},
                         @{@"title":@"sundy"}
                 ]
            }
                
        ].mutableCopy;
    }
}
@end
