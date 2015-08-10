//
//  ViewController.h
//  Gathr
//
//  Created by Poulose Matthen on 13/05/15.
//  Copyright (c) 2015 Zettanode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WhatWhereWhenViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) IBOutlet UILabel *whatLabel;
@property (strong, nonatomic) IBOutlet UILabel *whereLabel;
@property (strong, nonatomic) IBOutlet UILabel *whenLabel;

@property (strong, nonatomic) IBOutlet UILabel *breakLineLabel1;
@property (strong, nonatomic) IBOutlet UILabel *breakLineLabel2;

@property (strong, nonatomic) IBOutlet UIButton *menuButton1;
@property (strong, nonatomic) IBOutlet UIButton *menuButton2;
@property (strong, nonatomic) IBOutlet UITextField *fieldTextField1;
@property (strong, nonatomic) IBOutlet UIButton *menuButton3;
@property (strong, nonatomic) IBOutlet UITextField *fieldTextField2;

@property (strong, nonatomic) IBOutlet UIButton *whereMenuButton;
@property (strong, nonatomic) IBOutlet UITextField *whereFieldText;

@property (strong, nonatomic) IBOutlet UIButton *whenMenuButton1;
@property (strong, nonatomic) IBOutlet UIButton *whenMenuButton2;
@property (strong, nonatomic) IBOutlet UIButton *whenMenuButton3;
@property (strong, nonatomic) IBOutlet UIButton *whenMenuButton4;
@property (strong, nonatomic) IBOutlet UITextField *whenFieldText1;
@property (strong, nonatomic) IBOutlet UITextField *whenFieldText2;
@property (strong, nonatomic) IBOutlet UILabel *whenTimeColon;
@property (strong, nonatomic) IBOutlet UILabel *whenDurationLabel;

@property (strong, nonatomic) IBOutlet UIButton *createButton;

@property (strong, nonatomic) IBOutlet UITableView *menuButton1TableView;
@property (strong, nonatomic) IBOutlet UITableView *autoCompleteTableView;
@property (strong, nonatomic) IBOutlet UITableView *menuButton2TableView;
@property (strong, nonatomic) IBOutlet UITableView *menuButton3TableView;
@property (strong, nonatomic) IBOutlet UITableView *whereMenuButtonTableView;
@property (strong, nonatomic) IBOutlet UITableView *whereAutoCompleteTableView;
@property (strong, nonatomic) IBOutlet UITableView *whenMenuButton1TableView;
@property (strong, nonatomic) IBOutlet UITableView *whenMenuButton2TableView;
@property (strong, nonatomic) IBOutlet UITableView *whenMenuButton3TableView;
@property (strong, nonatomic) IBOutlet UITableView *whenMenuButton4TableView;

- (IBAction)menuButton1Pressed:(id)sender;
- (IBAction)menuButton2Pressed:(id)sender;
- (IBAction)menuButton3Pressed:(id)sender;
- (IBAction)whereButtonPressed:(id)sender;
- (IBAction)whenMenuButton1Pressed:(id)sender;
- (IBAction)whenMenuButton2Pressed:(id)sender;
- (IBAction)whenMenuButton3Pressed:(id)sender;
- (IBAction)whenMenuButton4Pressed:(id)sender;
- (IBAction)createButtonPressed:(id)sender;

@end

