//
//  main.m
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"
#import "SortingAlgorithm.h"

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

static const NSInteger kPersonCount = 1001;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *persons = [NSMutableArray arrayWithCapacity:kPersonCount];
        
        for (NSInteger i = 0; i < kPersonCount; i++) {
            persons[i] = [Person randomPerson];
        }
        
        NSMutableArray *sortingClasses = [NSMutableArray array];
        int count = objc_getClassList(NULL, 0);
        Class classes[count];
        objc_getClassList(classes, count);
        
        for(int i=0; i<count; i++){
            Class klass = classes[i];
            if(class_getSuperclass(klass) == [SortingAlgorithm class]){
                [sortingClasses addObject:klass];
            }
        }
        
        NSArray *referenceSortResult = [[persons copy] sortedArrayUsingComparator:^NSComparisonResult(Person *person1, Person *person2) {
            if (person1.age < person2.age) {
                return NSOrderedAscending;
            } else if (person1.age > person2.age) {
                return NSOrderedDescending;
            } else {
                NSComparisonResult lastNameCompare = [person1.lastName compare:person2.lastName];
                if (lastNameCompare != NSOrderedSame) {
                    return lastNameCompare;
                } else {
                    return [person1.firstName compare:person2.firstName];
                }
            }
        }];
        
        for (Class klass in sortingClasses) {
            __block NSArray *sortResult = nil;
            
            uint64_t t = dispatch_benchmark(3, ^{
                sortResult = [klass performSelector:@selector(sort:) withObject:[persons copy]];
            });
            
            int randomIndex = arc4random_uniform(kPersonCount);
            if (!(referenceSortResult[randomIndex] == sortResult[randomIndex])) {
                @throw [NSException exceptionWithName:@"Incorrect sorting" reason:@"Your sort algorithm is not sorting correctly" userInfo:nil];
            }
            
            NSLog(@"[%@] Avg. Runtime: %llu ms", NSStringFromClass(klass),t/1000000);
        }
    }
    
    return 0;
}