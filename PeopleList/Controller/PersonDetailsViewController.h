//
//  PersonDetailsViewController.h
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonDetailsViewController : UIViewController
@property (strong, nonatomic) Person *person;
@end

NS_ASSUME_NONNULL_END
