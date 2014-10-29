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

static const NSInteger kPersonCount = 1000;

NSArray *sortPersonsBubbleSort(NSArray *persons);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *persons = [NSMutableArray arrayWithCapacity:kPersonCount];
        
        for (NSInteger i = 0; i < kPersonCount; i++) {
            persons[i] = [Person randomPerson];
        }
        
        uint64_t t = dispatch_benchmark(3, ^{
            sortPersonsBubbleSort([persons copy]);
        });
        
        NSLog(@"[Bubble Sort] Avg. Runtime: %llu ms", t/1000000);
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