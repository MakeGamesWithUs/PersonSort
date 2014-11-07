//
//  BucketSort.m
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "BucketSort.h"
#import "BubbleSort.h"
#import "Person.h"

@implementation BucketSort

+ (NSArray *)sort:(NSArray *)persons {
    NSMutableDictionary *buckets = [NSMutableDictionary dictionary];
    // create buckets for all ages
    for (int i = 1; i <= 110; i++) {
        buckets[@(i)] = [NSMutableArray array];
    }
    
    // sort persons into buckets based on their age
    for (int i = 0; i < [persons count]; i++) {
        NSMutableArray *bucketArray = buckets[@([persons[i] age])];
        [bucketArray addObject:persons[i]];
    }
    
    // create an array to store the sort results
    NSMutableArray *sortedPersons = [NSMutableArray array];
    
    // get a sorted array of all bucket keys;
    NSArray *sortedKeys = [[buckets allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    // iterate over all buckets
    for (NSNumber *key in sortedKeys) {
        // get the persons for current bucket
        NSMutableArray *persons = buckets[key];
        
        // sort the bucket using the bubble sort algorithm
        persons = [[BubbleSort sort:persons] mutableCopy];
        
        // add the sorted bucket to the array holding the sort results
        [sortedPersons addObjectsFromArray:persons];
    }
    
    return sortedPersons;
}

@end