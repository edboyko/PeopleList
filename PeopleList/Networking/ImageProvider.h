//
//  ImageProvider.h
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageProvider : NSObject
-(void)downloadImageForName:(NSString*)name completion:(void (^)(UIImage* _Nullable image))completion;
-(void)stopDownload;
@end

NS_ASSUME_NONNULL_END
