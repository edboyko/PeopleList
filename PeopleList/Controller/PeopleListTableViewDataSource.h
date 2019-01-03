//
//  PeopleListTableViewDataSource.h
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PeopleListTableViewDataSource : NSObject
- (instancetype)initWithTableView:(UITableView*)tableView;
-(void)getPeople;
@end

NS_ASSUME_NONNULL_END
