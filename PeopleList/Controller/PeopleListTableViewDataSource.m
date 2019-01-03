//
//  PeopleListTableViewDataSource.m
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import "PeopleListTableViewDataSource.h"
#import "PeopleProvider.h"

@interface PeopleListTableViewDataSource () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) PeopleProvider *peopleProvider;
@property (strong, nonatomic) NSMutableArray<Person*> *people;
@end
@implementation PeopleListTableViewDataSource

- (instancetype)initWithTableView:(UITableView*)tableView
{
    self = [super init];
    if (self) {
        _peopleProvider = [[PeopleProvider alloc] init];
        _people = [NSMutableArray new];
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return self;
}

-(void)getPeople {
    [self.peopleProvider getPeopleWithCompletionBlock:^(NSArray * _Nullable people, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (people != nil) {
                [self.people addObjectsFromArray:people];
                [self.tableView reloadData];
            }
        });
    }];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.people.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PersonCell"];
    cell.textLabel.text = self.people[indexPath.row].name;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ cm %@ kg", @(self.people[indexPath.row].height).stringValue, @(self.people[indexPath.row].mass).stringValue];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.peopleProvider.hasMorePages) {
        return @"Loading...";
    }
    else {
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if (self.peopleProvider.hasMorePages) {
        [self getPeople];
    }
}

@end
