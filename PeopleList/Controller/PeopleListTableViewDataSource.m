//
//  PeopleListTableViewDataSource.m
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import "PeopleListTableViewDataSource.h"
#import "PeopleProvider.h"
#import "ImageProvider.h"

@interface PeopleListTableViewDataSource () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) PeopleProvider *peopleProvider;
@property (strong, nonatomic) NSMutableArray<Person*> *people;
@property (strong, nonatomic) NSMutableDictionary<NSString*, ImageProvider*> *imageProviders;
@end
@implementation PeopleListTableViewDataSource

- (instancetype)initWithTableView:(UITableView*)tableView
{
    self = [super init];
    if (self) {
        _peopleProvider = [[PeopleProvider alloc] init];
        _imageProviders = [NSMutableDictionary new];
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

// MARK: TableView DataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.people.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
    
    Person *person = self.people[indexPath.row];
    
    cell.textLabel.text = person.name;
    cell.imageView.image = nil;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Height: %@ cm, Mass: %@ kg", @(person.height).stringValue, @(person.mass).stringValue];
    ImageProvider *imageProvider = [[ImageProvider alloc]init];
    [self.imageProviders setObject:imageProvider forKey:person.name];
    NSString *encodedName = [person.name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    [imageProvider downloadImageForName:encodedName completion:^(UIImage * _Nullable image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
            [cell setNeedsLayout];
            [self.imageProviders removeObjectForKey:person.name];
        });
    }];
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

// MARK: TableView Delegate
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if (self.peopleProvider.hasMorePages) {
        [self getPeople];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    Person *person = self.people[indexPath.row];
    ImageProvider *imageProvider = self.imageProviders[person.name];
    [imageProvider stopDownload];
    [self.imageProviders removeObjectForKey:person.name];
}

@end
