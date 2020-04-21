//
//  BubbleSort.m
//  BaseAlgorithm
//
//  Created by CC on 2020/4/21.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "BubbleSort.h"
#import "TestUtil.h"
@implementation BubbleSort
-(void)test{
//    int *arr = [TestUtil createRandomNumbers:20];
    int arr[] = {1,3,11,3,5,6,7,33,16,75,14,88,91,34,65,65,23,21,37,68};
    [TestUtil printArray:arr length:20];
    [self sort:arr length:20];
    [TestUtil printArray:arr length:20];
}

-(void)sort:(int*)arr length:(int)length{
    for(int i=0; i<length;i++) {
        for (int j=i; j<length-1; j++) {
            if(arr[j]>arr[1+j]){
                int tmp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = tmp;
            }
        }
    }
}
@end
