//
//  SortingAlgorithm.m
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "SortingAlgorithm.h"

@implementation SortingAlgorithm

+ (NSArray *)sort:(NSArray *)persons {
    @throw [NSException exceptionWithName:@"Method 'sort' needs to be overriden" reason:@"Every subclass has to implement 'sort'" userInfo:nil];
}

@end