//
//  Person.h
//  PersonSort
//
//  Created by Benjamin Encz on 29/10/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) NSInteger age;

+ (instancetype)personWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSInteger)age;
+ (instancetype)randomPerson;

@end
