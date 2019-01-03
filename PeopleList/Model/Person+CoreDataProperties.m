//
//  Person+CoreDataProperties.m
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Person"];
}

@dynamic name;
@dynamic height;
@dynamic mass;
@dynamic hairColor;
@dynamic skinColor;
@dynamic eyeColor;
@dynamic birthYear;
@dynamic gender;

@end
