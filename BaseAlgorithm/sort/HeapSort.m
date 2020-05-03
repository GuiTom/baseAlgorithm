//
//  HeapSort.m
//  BaseAlgorithm
//
//  Created by CC on 2020/4/29.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "HeapSort.h"
#import "TestUtil.h"
@implementation HeapSort
-(void)test{
    int arr[] = {25,3,11,31,5,6,7,33,16,75,19,88,91,34,69,65,23,21,37,68};
    [TestUtil printArray:arr length:20];
    [self sort:arr length:20];
    [TestUtil printArray:arr length:20];
}
void swap(int *arr,int indexA,int indexB){
    printf("%d:%d %d:%d\n",indexA,arr[indexA],indexB,arr[indexB]);
    int tmp= arr[indexA];
    arr[indexA] = arr[indexB];
    arr[indexB] = tmp;
}
-(void)sort:(int *)arr length:(int)length{
    
     [TestUtil printArray:arr length:20];
    int lastParentIndex = length/2 - 1;
    int len = length;
    //建堆
    for(int i = lastParentIndex;i>=0;i--){
        heapify(arr, i, len--);
    }
    len = length;
    while (len) {
        swap(arr, 0, len-1);
        heapify(arr, 0, --len);
    }
}

/**
 建堆
 */
void heapify(int *arr,int  i,int length){
    int leftSon = 2*i+1;
    int rightSon = 2*i+2;
    while (leftSon<length) {
        int maxSon = leftSon;
        
        if(rightSon<length&&arr[leftSon]<arr[rightSon]){
            maxSon = rightSon;
        }
        if(arr[maxSon]>arr[i]){
            swap(arr, maxSon, i);
        }
        i = maxSon;
        leftSon = 2*i+1;
        rightSon = 2*i+2;
    }
    
}

@end
