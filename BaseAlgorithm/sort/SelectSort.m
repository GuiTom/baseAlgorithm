//
//  SelectSort.m
//  BaseAlgorithm
//
//  Created by CC on 2020/4/21.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "SelectSort.h"
#import "TestUtil.h"
@implementation SelectSort
-(void)test{
//    int *arr = [TestUtil createRandomNumbers:20];
    int arr[] = {1,3,11,3,5,6,7,33,16,75,14,88,91,34,65,65,23,21,37,68};
    [TestUtil printArray:arr length:20];
    [self sort:arr length:20];
    [TestUtil printArray:arr length:20];
}
-(void)sort:(int*)arr length:(int)length{
    for(int i=0; i<length;i++) {
        int min = i;
        for (int j=i+1; j<length; j++) {
            if(arr[min]>arr[j]){//找出这一趟比较的最小值
                min = j;
            }
        }
        if(min!=i){//将最小值与这一趟的起始位置的值交换
            int tmp = arr[i];
            arr[i] = arr[min];
            arr[min] = tmp;
        }
        
    }
}
@end
