//
//  Person.m
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "Person.h"

static NSArray *firstNames;
static NSArray *lastNames;

@implementation Person

+ (void)initialize {
    NSError *error = nil;
    NSString *filepathFirstNames = [[NSBundle mainBundle] pathForResource:@"firstnames" ofType:@"txt"];
    NSString *firstNamesAll = [NSString stringWithContentsOfFile:filepathFirstNames encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        @throw [NSException exceptionWithName:error.localizedDescription reason:error.localizedFailureReason userInfo:nil];
    }
    
    error = nil;
    NSString *filepathLastNames = [[NSBundle mainBundle] pathForResource:@"lastnames" ofType:@"txt"];
    NSString *lastNamesAll = [NSString stringWithContentsOfFile:filepathLastNames encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        @throw [NSException exceptionWithName:error.localizedDescription reason:error.localizedFailureReason userInfo:nil];
    }
    
    firstNames = [firstNamesAll componentsSeparatedByString:@"\n"];
    lastNames = [lastNamesAll componentsSeparatedByString:@"\n"];
}

+ (instancetype)personWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSInteger)age {
    Person *person = [Person new];
    person.firstName  = firstName;
    person.lastName = lastName;
    person.age = age;
    
    return person;
}

+ (instancetype)randomPerson {
    int firstNameRandomNumber = arc4random_uniform((int)[firstNames count]);
    int lastNameRandomNumber = arc4random_uniform((int)[lastNames count]);
    int randomAge = arc4random_uniform(110) + 1;
    
    return [Person personWithFirstName:firstNames[firstNameRandomNumber] lastName:lastNames[lastNameRandomNumber] age:randomAge];
}

#pragma mark - Description

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@, %ld", self.firstName, self.lastName, self.age];
}

@end
