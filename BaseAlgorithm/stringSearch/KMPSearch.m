//
//  KMPSearch.m
//  BaseAlgorithm
//
//  Created by CC on 2020/4/29.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "KMPSearch.h"

@implementation KMPSearch
-(void)test{
    char *stringTOSearch = "axssbdecabdecacabfd";
    char *subStr = "decabdec";
    int* next = getNext(subStr);
    NSInteger len = strlen(subStr);
    for (int i=0; i<len; i++) {
        printf("%d ",next[i]);
    }
    int index = search(stringTOSearch, subStr);
    printf("x -- %d",index);
}
int search(char *mainStr,char *subStr){
    NSInteger lenMain = strlen(mainStr);
    NSInteger lenSub = strlen(subStr);
    int* next = getNext(subStr);
    int index = -1;
    for (int i=0,k=0; i<lenMain;) {
        if(mainStr[i]==subStr[k]){
            k++;
            
            if(k>=lenSub){
                index = i+1 - (int)lenSub;
            }
            i++;
        }else {//失配
            
            if(k>0)
                k = next[k-1];
            else {
                i++;
            }
        }
        
    
        
    }
    return index;
}
int * getNext(char *str){
    NSInteger len = strlen(str);
    int *next = (int *)calloc(len, sizeof(int));
    for (int i=1,k=0; i<len; i++) {
        while (k>0&&str[k]!=str[i]) {
            k = next[k-1];
        }
        if(str[k]==str[i]){
            k++;
        }
        next[i] = k;
    }
    return next;
}
@end
