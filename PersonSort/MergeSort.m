//
//  MergeSort.m
//  PersonSort
//
//  Created by Benjamin Encz on 30/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "MergeSort.h"
#import "Person.h"

@implementation MergeSort

+ (NSArray *)sort:(NSArray *)persons {
    if ([persons count] <= 1) {
        return persons;
    }
    
    NSRange rangeFirstHalf = NSMakeRange(0, ([persons count] / 2));
    NSRange rangeSecondHalf = NSMakeRange([persons count] / 2, [persons count] - rangeFirstHalf.length);
    
    NSArray *arrayFirstHalf = [persons subarrayWithRange:rangeFirstHalf];
    NSArray *arraySecondHalf = [persons subarrayWithRange:rangeSecondHalf];
    
    NSArray *leftHalf = [self sort:arrayFirstHalf];
    NSArray *rightHalf = [self sort:arraySecondHalf];
    
    return [self mergeArrayOne:leftHalf arrayTwo:rightHalf];
}

+ (NSArray *)mergeArrayOne:(NSArray *)arrayOne arrayTwo:(NSArray *)arrayTwo {
    // merge
    NSMutableArray *arrayFirstHalf = [arrayOne mutableCopy];
    NSMutableArray *arraySecondHalf = [arrayTwo mutableCopy];
    
    NSMutableArray *mergedArray = [NSMutableArray array];

    while ([arrayFirstHalf count] > 0 && [arraySecondHalf count] > 0) {
        BOOL leftSmaller = NO;
        Person *personLeft = arrayFirstHalf[0];
        Person *personRight = arraySecondHalf[0];
        
        if (personLeft.age < personRight.age) {
            leftSmaller = YES;
        } else if (personLeft.age == personRight.age) {
            NSComparisonResult lastNameCompare = [[personLeft lastName] compare:[personRight lastName]];
            
            if (lastNameCompare == NSOrderedDescending) {
                leftSmaller = NO;
            } else if (lastNameCompare == NSOrderedAscending) {
                leftSmaller = YES;
            } else if (lastNameCompare == NSOrderedSame) {
                NSComparisonResult firstNameCompare = [[personLeft firstName] compare:[personRight firstName]];
                if (firstNameCompare == NSOrderedDescending) {
                    leftSmaller = NO;
                } else if (firstNameCompare == NSOrderedDescending) {
                    leftSmaller = YES;
                }
            }
        }
        
        if (leftSmaller) {
            [mergedArray addObject:arrayFirstHalf[0]];
            [arrayFirstHalf removeObjectAtIndex:0];
        } else {
            [mergedArray addObject:arraySecondHalf[0]];
            [arraySecondHalf removeObjectAtIndex:0];
        }
    }
    
    while ([arrayFirstHalf count] > 0) {
        [mergedArray addObject:arrayFirstHalf[0]];
        [arrayFirstHalf removeObjectAtIndex:0];
    }
    
    while ([arraySecondHalf count] > 0) {
        [mergedArray addObject:arraySecondHalf[0]];
        [arraySecondHalf removeObjectAtIndex:0];
    }
    
    return mergedArray;
}

@end
