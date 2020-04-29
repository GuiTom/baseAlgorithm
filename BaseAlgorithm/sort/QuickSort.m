//
//  QuickSort.m
//  BaseAlgorithm
//
//  Created by CC on 2020/4/29.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "QuickSort.h"
#import "TestUtil.h"
@implementation QuickSort
-(void)test{
    int arr[] = {25,3,11,31,5,6,7,33,16,75,19,88,91,34,69,65,23,21,37,68};
    [TestUtil printArray:arr length:20];
    [self sort:arr length:20];
    [TestUtil printArray:arr length:20];
}
-(void)sort:(int*)arr length:(int)length
{
    [self sort:arr startIndex:0 endIndex:length-1];
}
-(void)sort:(int*)arr startIndex:(int)startIndex endIndex:(int)endIndex{
    if(startIndex>=endIndex){
        return;
    }
    
    int left = startIndex;
    int right = endIndex;
    int  key = arr[left];
    BOOL isRight = true;//下一轮是否拿右边的比对
    while (left<right) {
            if(isRight){//拿右边的元素比对
                if(key>arr[right]){//右边的元素比 基准 key 小
                    arr[left++] = arr[right];//右边挪到左边
                    isRight = false;//下次从左边开始搜索
                }else {
                    right--;
                    isRight = true;
                }
            }else {//拿左边的元素比对
                if(key<arr[left]){//左边的比 基准 key 大
                    arr[right--] = arr[left];//左边的挪到右边
                    isRight = true;//下次从右边开始搜索
                }else {
                    left++;
                    isRight = false;
                }
            }
    }
    arr[left] = key;
    [self sort:arr startIndex:startIndex endIndex:left-1];
    [self sort:arr startIndex:left+1 endIndex:endIndex];
}
@end
