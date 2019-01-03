//
//  PersonDetailsViewController.m
//  PeopleList
//
//  Created by Edwin Boyko on 03/01/2019.
//  Copyright © 2019 Edwin Boyko. All rights reserved.
//

#import "PersonDetailsViewController.h"

@interface PersonDetailsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *personImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
@property (strong, nonatomic) IBOutlet UILabel *hairColorLabel;
@property (strong, nonatomic) IBOutlet UILabel *skinColorLabel;
@property (strong, nonatomic) IBOutlet UILabel *eyeColorLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthYearLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;

@end

@implementation PersonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self displayData];
}

-(void)displayData {
    self.nameLabel.text = self.person.name;
    self.heightLabel.text = [NSString stringWithFormat:@"%@ cm", @(self.person.height)];
    self.weightLabel.text = [NSString stringWithFormat:@"%@ kg", @(self.person.mass)];
    self.hairColorLabel.text = self.person.hairColor;
    self.skinColorLabel.text = self.person.skinColor;
    self.eyeColorLabel.text = self.person.eyeColor;
    self.birthYearLabel.text = self.person.birthYear;
    self.genderLabel.text = self.person.gender;
}

@end
