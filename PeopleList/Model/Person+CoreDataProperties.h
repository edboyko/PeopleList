//
//  Person+CoreDataProperties.h
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t height;
@property (nonatomic) int16_t mass;
@property (nullable, nonatomic, copy) NSString *hairColor;
@property (nullable, nonatomic, copy) NSString *skinColor;
@property (nullable, nonatomic, copy) NSString *eyeColor;
@property (nullable, nonatomic, copy) NSString *birthYear;
@property (nullable, nonatomic, copy) NSString *gender;

@end

NS_ASSUME_NONNULL_END
