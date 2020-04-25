//
//  MergeSort.m
//  BaseAlgorithm
//
//  Created by CC on 2020/4/21.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "MergeSort.h"
#import "TestUtil.h"
@implementation MergeSort
-(void)test{
//    int *arr = [TestUtil createRandomNumbers:20];
    int arr[] = {1,3,11,113,5,6,7,33,16,75,19,88,91,34,69,98,23,21,37,68};
    [TestUtil printArray:arr length:20];
    [self sort:arr length:20];
    [TestUtil printArray:arr length:20];
}
-(void)sort:(int*)arr length:(int)length{
    int tmpArr[20];
    [self merge:arr tmpArr:tmpArr startIndex:0 endIndex:length-1];
}
-(void)merge:(int *)sourceArr tmpArr:(int *)tmpArr startIndex:(int)startIndex endIndex:(int)endIndex{
    if(startIndex<endIndex){
    int middleIndex = startIndex + (endIndex-startIndex)/2;
//         printf("1 %d %d \n",startIndex,middleIndex);
        [self merge:sourceArr tmpArr:tmpArr startIndex:startIndex endIndex:middleIndex];

        [self merge:sourceArr tmpArr:tmpArr startIndex:middleIndex+1 endIndex:endIndex];
        
        [self merge:sourceArr tmpArr:tmpArr startIndex:startIndex middleIndex:middleIndex endIndex:endIndex];

    }
}
-(void)merge:(int *)sourceArr tmpArr:(int *)tmpArr startIndex:(int)startIndex middleIndex:(int)middleIndex endIndex:(int)endIndex{
    int i = startIndex,j = middleIndex+1,k = startIndex;
    while (i<=middleIndex&&j<=endIndex) {
     
        if(sourceArr[i] < sourceArr[j]){
            tmpArr[k++] = sourceArr[i++];
            
        }else {
            tmpArr[k++] = sourceArr[j++];
        }
        if(tmpArr[k-1]==5){
                 printf("\n 88-->");
        }
    }
    while (i<=middleIndex) {
    
        tmpArr[k++] = sourceArr[i++];
        if(tmpArr[k-1]==5){
                 printf("\n 88-->");
             }
    }
    while (j<=endIndex) {
        tmpArr[k++] = sourceArr[j++];
        if(tmpArr[k-1]==5){
                 printf("\n 88-->");
             }
    }
    for (int n = startIndex;n<=endIndex ; n++) {
        sourceArr[n] = tmpArr[n];
    }
//    memcpy(sourceArr, tmpArr, sizeof(int)*(endIndex-startIndex));
}
@end
