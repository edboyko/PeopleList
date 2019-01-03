//
//  ViewController.m
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import "PeopleListViewController.h"
#import "PeopleProvider.h"
#import "PeopleListTableViewDataSource.h"
#import "PersonDetailsViewController.h"

@interface PeopleListViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PeopleListTableViewDataSource *peopleDataSource;
@end

@implementation PeopleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _peopleDataSource = [[PeopleListTableViewDataSource alloc] initWithTableView:self.tableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDetails"]) {
        UITableViewCell *cell = (UITableViewCell*) sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        PersonDetailsViewController *detailsViewController = (PersonDetailsViewController*) segue.destinationViewController;
        
        Person *person = self.peopleDataSource.people[indexPath.row];
        detailsViewController.person = person;
        
    }
}

@end
