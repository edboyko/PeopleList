//
//  PeopleProvider.h
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
#import "StorageManager.h"

NS_ASSUME_NONNULL_BEGIN
@interface PeopleProvider : NSObject
@property (readonly) NSInteger currentPage;
@property (readonly) BOOL hasMorePages;
- (instancetype)init;
- (instancetype)initWithNetworkManager:(NetworkManager*)networkManager andStorageManager:(StorageManager*)storageManager;

-(void)getPeopleAtPage:(NSInteger)page withCompletionBlock:(void (^)(NSArray* _Nullable people, NSError* _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
