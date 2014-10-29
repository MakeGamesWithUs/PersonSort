//
//  main.m
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

static const NSInteger kPersonCount = 10000;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *persons = [NSMutableArray arrayWithCapacity:kPersonCount];
        
        for (NSInteger i = 0; i < kPersonCount; i++) {
            persons[i] = [Person randomPerson];
        }
        
        
        
    }
    return 0;
}