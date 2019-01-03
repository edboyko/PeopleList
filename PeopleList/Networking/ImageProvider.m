//
//  ImageProvider.m
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import "ImageProvider.h"
#import "NetworkManager.h"

@interface ImageProvider()
@property (strong, nonatomic) NetworkManager *networkManager;
@end

@implementation ImageProvider

-(NSURL*)imageURLForName:(NSString*)name {
    NSString *address = [NSString stringWithFormat:@"https://api.adorable.io/avatars/256/%@.png", name];
    return [NSURL URLWithString:address];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _networkManager = [[NetworkManager alloc] init];
    }
    return self;
}
-(void)downloadImageForName:(NSString*)name completion:(void (^)(UIImage* _Nullable image))completion {
    NSURL *url = [self imageURLForName:name];
    [self.networkManager loadDataFromURL:url withCompletionBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (data != nil) {
            UIImage *image = [UIImage imageWithData:data];
            completion(image);
        }
        else if (error != nil) {
            NSLog(@"Failed to download image: %@", error.localizedDescription);
        }
    }];
}

-(void)stopDownload {
    [self.networkManager cancel];
}

@end
