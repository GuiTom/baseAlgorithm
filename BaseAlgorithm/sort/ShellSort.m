//
//  ShellSort.m
//  BaseAlgorithm
//
//  Created by 陈超 on 2020/4/25.
//  Copyright © 2020年 kayak. All rights reserved.
//

#import "ShellSort.h"
#import "TestUtil.h"
@implementation ShellSort
-(void)test{
    int arr[] = {1,3,11,113,5,6,7,33,16,75,19,88,91,34,69,98,23,21,37,68};
    [TestUtil printArray:arr length:20];
    [self sort:arr length:20];
    [TestUtil printArray:arr length:20];
}
-(void)sort:(int*)arr length:(int)length{
    
}
@end
