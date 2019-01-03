//
//  PeopleProvider.m
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import "PeopleProvider.h"

@interface PeopleProvider()
@property (strong, nonatomic) NetworkManager *networkManager;
@property (strong, nonatomic) StorageManager *storageManager;
@property NSInteger currentPage;
@property BOOL hasMorePages;
@end

@implementation PeopleProvider

+(NSString*)baseURLAddress {
    return @"https://swapi.co/api/people/";
}

- (instancetype)initWithNetworkManager:(NetworkManager*)networkManager andStorageManager:(StorageManager*)storageManager
{
    self = [super init];
    if (self) {
        _networkManager = networkManager;
        _storageManager = storageManager;
        _currentPage = 1;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _networkManager = [[NetworkManager alloc] init];
        _storageManager = [[StorageManager alloc] init];
        _currentPage = 1;
    }
    return self;
}

-(void)getPeopleAtPage:(NSInteger)page withCompletionBlock:(void (^)(NSArray* _Nullable people, NSError* _Nullable error))completion {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:PeopleProvider.baseURLAddress];
    NSString *pageString = @(page).stringValue;
    urlComponents.queryItems = @[
                                 [NSURLQueryItem queryItemWithName:@"page" value:pageString]
                                 ];
    
    [self.networkManager loadDataFromURL:urlComponents.URL withCompletionBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error != nil) {
            if (error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorTimedOut) {
                NSArray<Person*> *savedPeople = [self.storageManager getSavedPeople];
                self.hasMorePages = false;
                completion(savedPeople, error);
            }
            else {
                completion(nil, error);
            }
        }
        else if (data != nil) {
            NSError *deserializationError;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&deserializationError];
            if (deserializationError != nil) {
                completion(nil, deserializationError);
            }
            else {
                
                NSArray *responsePeople = result[@"results"];
                self.hasMorePages = result[@"next"] != [NSNull null];
                NSArray<Person*> *persistentPeople = [self.storageManager savePeople:responsePeople];
                self.currentPage += 1;
                completion(persistentPeople, nil);
            }
        }
        else {
            completion(nil, error);
        }
    }];
}

@end
