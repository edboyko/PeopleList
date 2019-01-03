//
//  StorageManager.m
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import "StorageManager.h"

@interface StorageManager()

@property (strong) NSPersistentContainer *persistentContainer;

@end
@implementation StorageManager
- (instancetype)initWithPersistentContainer:(NSPersistentContainer*)persistentContainer
{
    self = [super init];
    if (self) {
        _persistentContainer = persistentContainer;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _persistentContainer = AppDelegate.instance.persistentContainer;
    }
    return self;
}

-(NSArray<Person*>*)getSavedPeopleWithPredicate:(nullable NSPredicate*)predicate {
    NSFetchRequest *request = Person.fetchRequest;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    request.sortDescriptors = @[descriptor];
    request.predicate = predicate;
    request.fetchBatchSize = 30;
    __block NSArray<Person*> *people;
    __weak StorageManager *weakSelf = self;
    [[self mainContext] performBlockAndWait:^{
        NSError *fetchError;
        people = [[weakSelf mainContext] executeFetchRequest:request error:&fetchError];
    }];
    return people;
}

-(NSArray<Person*>*)getSavedPeople {
    return [self getSavedPeopleWithPredicate:nil];
}

-(NSArray<Person*>*)savePeople:(NSArray<NSDictionary*>*)temporaryPeople {
    NSManagedObjectContext *bgContext = self.persistentContainer.newBackgroundContext;
    NSMutableArray<NSString*>* names = [NSMutableArray new];
    for (NSDictionary *personDict in temporaryPeople) {
        [names addObject:personDict[@"name"]];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name in %@" argumentArray:@[names]];
    [bgContext performBlockAndWait:^{
        
        bgContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
        bgContext.undoManager = nil;
        NSFetchRequest *request = Person.fetchRequest;
        request.predicate = predicate;
        NSError *fetchError = nil;
        NSArray *existingUsers = [bgContext executeFetchRequest:request error:&fetchError];
        if (fetchError != nil) {
            NSLog(@"error: %@", fetchError.localizedDescription);
            return;
        }
        
        for (NSManagedObject *user in existingUsers) {
            [bgContext deleteObject:user];
        }
        
        for (NSDictionary *userDictionary in temporaryPeople) {
            [self createPersonFromDictionary:userDictionary inContext:bgContext];
        }
        NSError *saveError;
        [bgContext save:&saveError];
        if (saveError != nil) {
            return;
        }
    }];
    
    return [self getSavedPeopleWithPredicate:predicate];
}

-(void)createPersonFromDictionary:(NSDictionary*)userDictionary inContext:(NSManagedObjectContext*)context {
    Person *person = [[Person alloc]initWithContext:context];
    person.name = userDictionary[@"name"];
    person.mass = [userDictionary[@"mass"] intValue];
    person.height = [userDictionary[@"height"] intValue];
    person.hairColor = userDictionary[@"hair_color"];
    person.skinColor = userDictionary[@"skin_color"];
    person.eyeColor = userDictionary[@"eye_color"];
    person.birthYear = userDictionary[@"birth_year"];
    person.gender = userDictionary[@"gender"];
}

-(NSManagedObjectContext*)mainContext {
    return self.persistentContainer.viewContext;
}
- (void)saveContext {
    NSManagedObjectContext *context = [self mainContext];
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
