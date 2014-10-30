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
    NSRange rangeFirstHalf = NSMakeRange(0, ([persons count] / 2));
    NSRange rangeSecondHalf = NSMakeRange([persons count] / 2, [persons count] - rangeFirstHalf.length);
    
    NSArray *arrayFirstHalf = [persons subarrayWithRange:rangeFirstHalf];
    NSArray *arraySecondHalf = [persons subarrayWithRange:rangeSecondHalf];
    
    if ([arrayFirstHalf count] > 1 || [arraySecondHalf count] > 1) {
        NSArray *leftHalf = [self sort:arrayFirstHalf];
        NSArray *rightHalf = [self sort:arraySecondHalf];
        
        return [self mergeArrayOne:leftHalf arrayTwo:rightHalf];
    } else {
        return [self mergeArrayOne:arrayFirstHalf arrayTwo:arraySecondHalf];
    }
}

+ (NSArray *)mergeArrayOne:(NSArray *)arrayFirstHalf arrayTwo:(NSArray *)arraySecondHalf {
    // merge
    
    if ([arrayFirstHalf count] == 0) {
        return arraySecondHalf;
    } else if ([arraySecondHalf count] == 0) {
        return arrayFirstHalf;
    }
    
    NSMutableArray *mergedArray = [NSMutableArray array];
    [mergedArray addObjectsFromArray:arrayFirstHalf];
    
    for (int i = 0; i < [arraySecondHalf count]; i++) {
        Person *selectedPerson = arraySecondHalf[i];
        
        NSInteger targetIndex = [mergedArray count];
        BOOL smaller = YES;
        while (smaller) {
            smaller = NO;
            Person *otherPerson = mergedArray[targetIndex-1];
            
            if (selectedPerson.age < otherPerson.age) {
                smaller = YES;
            } else if (selectedPerson.age == otherPerson.age) {
                NSComparisonResult lastNameCompare = [[otherPerson lastName] compare:[selectedPerson lastName]];
                
                if (lastNameCompare == NSOrderedDescending) {
                    smaller = YES;
                } else if (lastNameCompare == NSOrderedSame) {
                    NSComparisonResult firstNameCompare = [[otherPerson firstName] compare:[selectedPerson firstName]];
                    if (firstNameCompare == NSOrderedDescending) {
                        smaller = YES;
                    }
                }
            }
            
            if (smaller && targetIndex > 0) {
                targetIndex --;
            }
            
            if (!smaller || targetIndex == 0) {
                [mergedArray insertObject:selectedPerson atIndex:targetIndex];
                break;
            }
        }
    }
    
    return mergedArray;
}

@end
