//
//  NetworkManager.m
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation NetworkManager

- (instancetype)initWithSession:(NSURLSession*)session
{
    self = [super init];
    if (self) {
        _session = session;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _session = NSURLSession.sharedSession;
    }
    return self;
}

-(void)loadDataFromURL:(NSURL*)url withCompletionBlock:(void (^)(NSData* data, NSError* error))completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(data, error);
    }];
    [self.dataTask resume];
}

-(void)cancel {
    if (self.dataTask.state == NSURLSessionTaskStateRunning) {
        [self.dataTask cancel];
    }
}

@end
