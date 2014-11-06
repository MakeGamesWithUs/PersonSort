//
//  BubbleSort.m
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "BubbleSort.h"
#import "Person.h"

@implementation BubbleSort

+ (NSArray *)sort:(NSArray *)persons {
    NSMutableArray *sortedPersons = [persons mutableCopy];
    
    BOOL swapped = YES;

    while (swapped) {
        swapped = NO;

        // keep comparing all values to their neighbours until no swap occured in an entire iteration
        for (int i = 0; i+1 < [sortedPersons count]; i++) {
            BOOL needsSwap = NO;
            
            // compare the element to its neighbour
            if ([sortedPersons[i] age] > [sortedPersons[i+1] age]) {
                // if the left neighbor is older than the right neighbor, swap them
                needsSwap = YES;
            } else if ([sortedPersons[i] age] == [sortedPersons[i+1] age]) {
                // if both have the same age we need to check the second criteria; the last name
                NSComparisonResult lastNameCompare = [[sortedPersons[i] lastName] compare:[sortedPersons[i+1] lastName]];
                
                if (lastNameCompare == NSOrderedDescending) {
                    needsSwap = YES;
                } else if (lastNameCompare == NSOrderedSame) {
                    // if the last names are the same we need to check the first name
                    NSComparisonResult firstNameCompare = [[sortedPersons[i] firstName] compare:[sortedPersons[i+1] firstName]];
                    if (firstNameCompare == NSOrderedDescending) {
                        needsSwap = YES;
                    }
                }
            }
            
            // if a swap is necessarz; peform it here
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

@end
