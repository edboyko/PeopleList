//
//  NetworkManager.h
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject
- (instancetype)init;
-(void)loadDataFromURL:(NSURL*)url withCompletionBlock:(void (^)(NSData* _Nullable data, NSError* _Nullable error))completion;
-(void)cancel;
@end

NS_ASSUME_NONNULL_END
