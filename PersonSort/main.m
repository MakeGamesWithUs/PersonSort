//
//  main.m
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

static const NSInteger kPersonCount = 10000;

NSArray *sortPersonsBubbleSort(NSArray *persons);
NSArray *sortPersonsBucketSort(NSArray *persons);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *persons = [NSMutableArray arrayWithCapacity:kPersonCount];
        
        for (NSInteger i = 0; i < kPersonCount; i++) {
            persons[i] = [Person randomPerson];
        }
        
//        __block NSArray *sortedBubble = nil;
//        
//        uint64_t t = dispatch_benchmark(3, ^{
//            sortedBubble = sortPersonsBubbleSort([persons copy]);
//        });
        
        __block NSArray *sortedBucket = nil;

        uint64_t tBucket = dispatch_benchmark(3, ^{
            sortedBucket = sortPersonsBucketSort([persons copy]);
        });
        
        __block NSArray *sortedComparator = nil;
        
        uint64_t tComparator = dispatch_benchmark(3, ^{
            sortedComparator = [[persons copy] sortedArrayUsingComparator:^NSComparisonResult(Person *person1, Person *person2) {
                if (person1.age < person2.age) {
                    return NSOrderedDescending;
                } else if (person1.age > person2.age) {
                    return NSOrderedAscending;
                } else {
                    NSComparisonResult lastNameCompare = [person1.lastName compare:person2.lastName];
                    if (lastNameCompare != NSOrderedSame) {
                        return lastNameCompare;
                    } else {
                        return [person1.firstName compare:person2.firstName];
                    }
                }
            }];
        });
        
//        if (!( (sortedBubble[333] == sortedBucket[333]) && (sortedComparator[333] && sortedBucket[333]))) {
//            @throw [NSException exceptionWithName:@"Incorrect sorting" reason:@"Both algorithms should sort the same way!" userInfo:nil];
//        }
//        
//        NSLog(@"[Bubble Sort] Avg. Runtime: %llu ms", t/1000000);
        NSLog(@"[Bucket Sort] Avg. Runtime: %llu ms", tBucket/1000000);
        NSLog(@"[Comparator Sort] Avg. Runtime: %llu ms", tComparator/1000000);
    }
    return 0;
}

NSArray* sortPersonsBubbleSort(NSArray *persons) {
    NSMutableArray *sortedPersons = [persons mutableCopy];
    
    BOOL swapped = YES;
    
    while (swapped) {
        swapped = NO;
        
        for (int i = 0; i+1 < [sortedPersons count]; i++) {
            BOOL needsSwap = NO;
            
            if ([sortedPersons[i] age] > [sortedPersons[i+1] age]) {
                // swap the elements
                needsSwap = YES;
            } else if ([sortedPersons[i] age] == [sortedPersons[i+1] age]) {
                NSComparisonResult lastNameCompare = [[sortedPersons[i] lastName] compare:[sortedPersons[i+1] lastName]];
                
                if (lastNameCompare == NSOrderedDescending) {
                    needsSwap = YES;
                } else if (lastNameCompare == NSOrderedSame) {
                    NSComparisonResult firstNameCompare = [[sortedPersons[i] firstName] compare:[sortedPersons[i+1] firstName]];
                    if (firstNameCompare == NSOrderedDescending) {
                        needsSwap = YES;
                    }
                }
            }
            
            if (needsSwap) {
                Person *temp = sortedPersons[i];
                sortedPersons[i] = sortedPersons[i+1];
                sortedPersons[i+1] = temp;
                swapped = YES;
            }
        }
        
        if (!swapped) {
            // if there was an entire round without swapping any elements, we are done sorting
            return sortedPersons;
        }
    }
    
    return sortedPersons;
}

NSArray* sortPersonsBucketSort(NSArray *persons) {
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