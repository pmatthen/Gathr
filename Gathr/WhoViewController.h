//
//  WhoViewController.h
//  Gathr
//
//  Created by Poulose Matthen on 21/07/15.
//  Copyright (c) 2015 Zettanode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *whoTextField;
@property (strong, nonatomic) IBOutlet UITableView *whoTableView;
@property (strong, nonatomic) IBOutlet UIButton *profileButton1;
@property (strong, nonatomic) IBOutlet UIButton *profileButton2;
@property (strong, nonatomic) IBOutlet UIButton *profileButton3;
@property (strong, nonatomic) IBOutlet UILabel *moreFriendsLabel;

@property (strong, nonatomic) IBOutlet UIButton *rideTheWaveHelpButton;
@property (strong, nonatomic) IBOutlet UIButton *onOffButton;
@property (strong, nonatomic) IBOutlet UIButton *rideTheWaveButton1;
@property (strong, nonatomic) IBOutlet UITableView *rideTheWaveButton1TableView;
@property (strong, nonatomic) IBOutlet UITextField *rideTheWaveTextField;
@property (strong, nonatomic) IBOutlet UIButton *rideTheWaveButton2;
@property (strong, nonatomic) IBOutlet UITableView *rideTheWaveButton2TableView;
@property (strong, nonatomic) IBOutlet UIButton *openProfileButton;
@property (strong, nonatomic) IBOutlet UIButton *gathrButton;

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIButton *progressViewButton1;
@property (strong, nonatomic) IBOutlet UIButton *progressViewButton2;
@property (strong, nonatomic) IBOutlet UIButton *progressViewButton3;
@property (strong, nonatomic) IBOutlet UIButton *progressViewButton4;
@property (strong, nonatomic) IBOutlet UIButton *progressViewButton5;

@property (strong, nonatomic) IBOutlet UILabel *progressViewLabel1;
@property (strong, nonatomic) IBOutlet UILabel *progressViewLabel2;
@property (strong, nonatomic) IBOutlet UILabel *progressViewLabel3;
@property (strong, nonatomic) IBOutlet UILabel *progressViewLabel4;


- (IBAction)profileButton1Pressed:(id)sender;
- (IBAction)profileButton2Pressed:(id)sender;
- (IBAction)profileButton3Pressed:(id)sender;
- (IBAction)rideTheWaveHelpButtonPressed:(id)sender;
- (IBAction)rideTheWaveOnOffSwitchPressed:(id)sender;
- (IBAction)rideTheWaveButton1Pressed:(id)sender;
- (IBAction)rideTheWaveButton2Pressed:(id)sender;
- (IBAction)openProfileButtonPressed:(id)sender;
- (IBAction)gathrButtonPressed:(id)sender;

- (IBAction)progressViewButton1Pressed:(id)sender;
- (IBAction)progressViewButton2Pressed:(id)sender;
- (IBAction)progressViewButton3Pressed:(id)sender;
- (IBAction)progressViewButton4Pressed:(id)sender;
- (IBAction)progressViewButton5Pressed:(id)sender;

@end
