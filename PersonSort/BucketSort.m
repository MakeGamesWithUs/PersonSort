//
//  BucketSort.m
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "BucketSort.h"
#import "Person.h"
#import "MergeSort.h"

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
        [sortedPersons addObjectsFromArray:[MergeSort sort:[persons copy]]];
    }
    
    return sortedPersons;
}

@end