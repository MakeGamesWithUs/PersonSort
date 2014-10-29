//
//  BucketSort.m
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "BucketSort.h"
#import "Person.h"

@implementation BucketSort

+ (NSArray *)sort:(NSArray *)persons {
    NSMutableDictionary *buckets = [NSMutableDictionary dictionary];
    // create buckets for all ages
    for (int i = 1; i <= 110; i++) {
        buckets[@(i)] = [NSMutableArray array];
    }
    
    // sort persons into buckets
    for (int i = 0; i < [persons count]; i++) {
        NSMutableArray *bucketArray = buckets[@([persons[i] age])];
        [bucketArray addObject:persons[i]];
    }
    
    NSMutableArray *sortedPersons = [NSMutableArray array];
    
    NSArray *sortedKeys = [[buckets allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    for (NSNumber *key in sortedKeys) {
        NSMutableArray *persons = buckets[key];
        
        BOOL swapped = YES;
        
        while (swapped) {
            swapped = NO;
            
            for (int i = 0; i+1 < [persons count]; i++) {
                BOOL needsSwap = NO;
                
                NSComparisonResult lastNameCompare = [[persons[i] lastName] compare:[persons[i+1] lastName]];
                
                if (lastNameCompare == NSOrderedDescending) {
                    needsSwap = YES;
                } else if (lastNameCompare == NSOrderedSame) {
                    NSComparisonResult firstNameCompare = [[persons[i] firstName] compare:[persons[i+1] firstName]];
                    if (firstNameCompare == NSOrderedDescending) {
                        needsSwap = YES;
                    }
                }
                
                if (needsSwap) {
                    Person *temp = persons[i];
                    persons[i] = persons[i+1];
                    persons[i+1] = temp;
                    swapped = YES;
                }
            }
        }
        
        [sortedPersons addObjectsFromArray:persons];
    }
    
    return sortedPersons;
}

@end