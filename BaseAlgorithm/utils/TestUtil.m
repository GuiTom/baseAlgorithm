//
//  TestUtil.m
//  BaseAlgorithm
//
//  Created by CC on 2020/4/21.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "TestUtil.h"

@implementation TestUtil
+(int *)createRandomNumbers:(int)length{
    int *arr = (int*)calloc(length, sizeof(int));
    srand((unsigned)time(NULL));
    for (int i=0; i<20; i++) {
        usleep(200);
        int num = rand()%100;
        arr[i] = num;
    }
    return arr;
}
+(void)printArray:(int *)array length:(int)length{
    for (int i = 0; i < length; i++) {
        if(!i%10){
              printf("\n");
        }
        printf(" %d",array[i]);
    }
}
+(void)execTest:(void(^)(void))block{
    NSDate *date = [NSDate date];
    if(block){
        block();
    }
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
    NSLog(@"用时 %f ms",interval*1000);
}
@end
