//
//  StorageManager.h
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Person+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN
@interface StorageManager : NSObject

- (instancetype)initWithPersistentContainer:(NSPersistentContainer*)persistentContainer;
- (instancetype)init;
-(NSArray<Person*>*)getSavedPeopleWithPredicate:(nullable NSPredicate*)predicate;
-(NSArray<Person*>*)getSavedPeople;
-(NSArray<Person*>*)savePeople:(NSArray<NSDictionary*>*)temporaryPeople;
- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
