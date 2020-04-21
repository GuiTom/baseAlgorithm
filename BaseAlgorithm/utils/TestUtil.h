//
//  TestUtil.h
//  BaseAlgorithm
//
//  Created by CC on 2020/4/21.
//  Copyright © 2020 kayak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestUtil : NSObject
+(int *)createRandomNumbers:(int)length;
+(void)printArray:(int *)array length:(int)length;
@end

NS_ASSUME_NONNULL_END
