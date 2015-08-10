//
//  WhoViewController.m
//  Gathr
//
//  Created by Poulose Matthen on 21/07/15.
//  Copyright (c) 2015 Zettanode. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "WhoViewController.h"
#import "FriendsAutoCompleteTableViewCell.h"
#import "RideTheWaveButton1TableViewCell.h"
#import "RideTheWaveButton2TableViewCell.h"

#define TABLEVIEW_MAX_HEIGHT 300
#define TABLEVIEWCELL_ROW_HEIGHT 30

@interface WhoViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableArray *friendsNameArray;
@property (strong, nonatomic) NSMutableArray *friendsNameAutocompleteArray;
@property (strong, nonatomic) NSMutableArray *addedFriends;
@property (strong, nonatomic) NSString *friendToRemove;
@property BOOL switchOnOrOff;
@property (strong, nonatomic) NSMutableArray *howManyPeopleListArray;
@property (strong, nonatomic) NSMutableArray *genderListArray;

@property BOOL rideTheWaveButton1TableViewOpen;
@property BOOL rideTheWaveButton2TableViewOpen;

@end

@implementation WhoViewController
@synthesize friendsNameArray, friendsNameAutocompleteArray, addedFriends, whoTextField, profileButton1, profileButton2, profileButton3, moreFriendsLabel, rideTheWaveHelpButton, onOffButton, rideTheWaveButton1, rideTheWaveTextField, rideTheWaveButton2, openProfileButton, gathrButton, whoTableView, rideTheWaveButton1TableView, rideTheWaveButton2TableView, friendToRemove, switchOnOrOff, howManyPeopleListArray, genderListArray, rideTheWaveButton1TableViewOpen, rideTheWaveButton2TableViewOpen, progressView, progressViewButton1, progressViewButton2, progressViewButton3, progressViewButton4, progressViewButton5, progressViewLabel1, progressViewLabel2, progressViewLabel3, progressViewLabel4;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [tapGestureRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer setDelegate:self];
    
    switchOnOrOff = NO;
    
    friendsNameAutocompleteArray = [NSMutableArray new];
    friendsNameArray = [NSMutableArray new];
    addedFriends = [NSMutableArray new];
    howManyPeopleListArray = [self howManyPeopleList];
    genderListArray = [self genderList];
    
    friendsNameArray = [self friendsNames];
    
    rideTheWaveButton1TableViewOpen = NO;
    rideTheWaveButton2TableViewOpen = NO;
    
    [whoTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self makeProgressViewButtonsRound];
}

-(void) makeProgressViewButtonsRound {
    progressViewButton1.clipsToBounds = YES;
    progressViewButton2.clipsToBounds = YES;
    progressViewButton3.clipsToBounds = YES;
    progressViewButton4.clipsToBounds = YES;
    progressViewButton5.clipsToBounds = YES;
    
    progressViewButton1.layer.cornerRadius = 20/2.0f;
    progressViewButton2.layer.cornerRadius = 20/2.0f;
    progressViewButton3.layer.cornerRadius = 20/2.0f;
    progressViewButton4.layer.cornerRadius = 20/2.0f;
    progressViewButton5.layer.cornerRadius = 20/2.0f;
    
    progressViewButton1.layer.borderColor=[UIColor orangeColor].CGColor;
    progressViewButton2.layer.borderColor=[UIColor orangeColor].CGColor;
    progressViewButton3.layer.borderColor=[UIColor orangeColor].CGColor;
    progressViewButton4.layer.borderColor=[UIColor orangeColor].CGColor;
    progressViewButton5.layer.borderColor=[UIColor orangeColor].CGColor;
    
    progressViewButton1.layer.borderWidth=2.0f;
    progressViewButton2.layer.borderWidth=2.0f;
    progressViewButton3.layer.borderWidth=2.0f;
    progressViewButton4.layer.borderWidth=2.0f;
    progressViewButton5.layer.borderWidth=2.0f;
}

- (NSMutableArray *) friendsNames {
    NSMutableArray *friends = [[NSMutableArray alloc]
                               initWithArray:@[@"sophia",
                                                  @"jackson",
                                                  @"emma",
                                                  @"aiden",
                                                  @"olivia",
                                                  @"liam",
                                                  @"ava",
                                                  @"lucas",
                                                  @"isabella",
                                                  @"noah",
                                                  @"mia",
                                                  @"mason",
                                                  @"zoe",
                                                  @"ethan",
                                                  @"lily",
                                                  @"jacob"]];
    
    return friends;
    
}

- (NSMutableArray *) howManyPeopleList {
    NSMutableArray *howManyPeople = [[NSMutableArray alloc]
                               initWithArray:@[@"around",
                                               @"at least",
                                               @"at most",
                                               @"exactly"]];
    
    return howManyPeople;
    
}

- (NSMutableArray *) genderList {
    NSMutableArray *genders = [[NSMutableArray alloc]
                                     initWithArray:@[@"any",
                                                     @"male",
                                                     @"female"]];
    
    return genders;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == whoTableView) {
        return [friendsNameAutocompleteArray count];
    }
    if (tableView == rideTheWaveButton1TableView) {
        return [howManyPeopleListArray count];
    }
    if (tableView == rideTheWaveButton2TableView) {
        return [genderListArray count];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == whoTableView) {
        NSString *cellIdentifier = @"FriendsAutoCompleteCell";
        FriendsAutoCompleteTableViewCell *cell = (FriendsAutoCompleteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = friendsNameAutocompleteArray[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor orangeColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == rideTheWaveButton1TableView) {
        NSString *cellIdentifier = @"HowManyPeopleCell";
        RideTheWaveButton1TableViewCell *cell = (RideTheWaveButton1TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = howManyPeopleListArray[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor orangeColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == rideTheWaveButton2TableView) {
        NSString *cellIdentifier = @"GenderCell";
        RideTheWaveButton2TableViewCell *cell = (RideTheWaveButton2TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = genderListArray[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor orangeColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == whoTableView) {
        [whoTextField setText:@""];
        [addedFriends addObject:friendsNameAutocompleteArray[indexPath.row]];
        [self populateProfileButtons];
        whoTableView.hidden = YES;
    }
    if (tableView == rideTheWaveButton1TableView) {
        [rideTheWaveButton1 setTitle:howManyPeopleListArray[indexPath.row] forState:UIControlStateNormal];
        [self performSelector:@selector(showHideDropdown:) withObject:rideTheWaveButton1TableView afterDelay:0];
    }
    if (tableView == rideTheWaveButton2TableView) {
        [rideTheWaveButton2 setTitle:genderListArray[indexPath.row] forState:UIControlStateNormal];
        [self performSelector:@selector(showHideDropdown:) withObject:rideTheWaveButton2TableView afterDelay:0];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TABLEVIEWCELL_ROW_HEIGHT;
}

-(void) showHideDropdown:(UITableView *)sender {
    [whoTableView setFrame:CGRectMake(whoTableView.frame.origin.x, whoTableView.frame.origin.y , whoTableView.frame.size.width, 0)];
    whoTableView.hidden = YES;
    
    [rideTheWaveButton1TableView setFrame:CGRectMake(rideTheWaveButton1TableView.frame.origin.x, rideTheWaveButton1TableView.frame.origin.y , rideTheWaveButton1TableView.frame.size.width, 0)];
    rideTheWaveButton1TableView.hidden = YES;
    
    if (sender.tag == 1) {
        if (rideTheWaveButton1TableViewOpen == NO) {
            [self.view bringSubviewToFront:rideTheWaveButton1TableView];
            rideTheWaveButton1TableViewOpen = YES;
            rideTheWaveButton1TableView.hidden = NO;
            [rideTheWaveButton1TableView setFrame:CGRectMake(rideTheWaveButton1TableView.frame.origin.x, rideTheWaveButton1TableView.frame.origin.y, rideTheWaveButton1TableView.frame.size.width, rideTheWaveButton1TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [rideTheWaveButton1TableView setFrame:CGRectMake(rideTheWaveButton1TableView.frame.origin.x, rideTheWaveButton1TableView.frame.origin.y, rideTheWaveButton1TableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [howManyPeopleListArray count]))];
            [UIView commitAnimations];
        }
        
        else if (rideTheWaveButton1TableViewOpen == YES) {
            rideTheWaveButton1TableViewOpen = NO;
            [rideTheWaveButton1TableView setFrame:CGRectMake(rideTheWaveButton1TableView.frame.origin.x, rideTheWaveButton1TableView.frame.origin.y, rideTheWaveButton1TableView.frame.size.width, rideTheWaveButton1TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [rideTheWaveButton1TableView setFrame:CGRectMake(rideTheWaveButton1TableView.frame.origin.x, rideTheWaveButton1TableView.frame.origin.y , rideTheWaveButton1TableView.frame.size.width, 0)];
            rideTheWaveButton1TableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
    
    if (sender.tag == 2) {
        if (rideTheWaveButton2TableViewOpen == NO) {
            [self.view bringSubviewToFront:rideTheWaveButton2TableView];
            rideTheWaveButton2TableViewOpen = YES;
            rideTheWaveButton2TableView.hidden = NO;
            [rideTheWaveButton2TableView setFrame:CGRectMake(rideTheWaveButton2TableView.frame.origin.x, rideTheWaveButton2TableView.frame.origin.y, rideTheWaveButton2TableView.frame.size.width, rideTheWaveButton2TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [rideTheWaveButton2TableView setFrame:CGRectMake(rideTheWaveButton2TableView.frame.origin.x, rideTheWaveButton2TableView.frame.origin.y, rideTheWaveButton2TableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [genderListArray count]))];
            [UIView commitAnimations];
        }
        
        else if (rideTheWaveButton2TableViewOpen == YES) {
            rideTheWaveButton2TableViewOpen = NO;
            [rideTheWaveButton2TableView setFrame:CGRectMake(rideTheWaveButton2TableView.frame.origin.x, rideTheWaveButton2TableView.frame.origin.y, rideTheWaveButton2TableView.frame.size.width, rideTheWaveButton2TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [rideTheWaveButton2TableView setFrame:CGRectMake(rideTheWaveButton2TableView.frame.origin.x, rideTheWaveButton2TableView.frame.origin.y , rideTheWaveButton2TableView.frame.size.width, 0)];
            rideTheWaveButton2TableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:whoTableView]) {
        
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer {
    for (UITextField *myTextField in self.view.subviews) {
        [myTextField resignFirstResponder];
    }
}

-(void) textFieldDidChange:(UITextField *)senderTextField {
    if (senderTextField.tag == 0) {
        if ([senderTextField.text isEqualToString:@""]) {
            whoTableView.hidden = YES;
        } else {
            whoTableView.hidden = NO;
        }
        
        [self searchAutocompleteEntriesWithSubstringInTextField:senderTextField];
    }
}

- (void)searchAutocompleteEntriesWithSubstringInTextField:(UITextField *)senderTextField {
    
    // Put anything that contains this substring into the autoCompleteArray
    // The items in this array is what will show up in the table view
    
    [friendsNameAutocompleteArray removeAllObjects];
    
    for(NSString *nameString in [self friendsNames]) {
        NSRange substringRange = [nameString rangeOfString:senderTextField.text];
        if (substringRange.location != NSNotFound) {
            [friendsNameAutocompleteArray addObject:nameString];
        }
    }
    
    [self.view bringSubviewToFront:whoTableView];
    
    if ([friendsNameAutocompleteArray count] >= 10) {
        [whoTableView setFrame:CGRectMake(whoTableView.frame.origin.x, whoTableView.frame.origin.y, whoTableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
        [whoTableView reloadData];
    } else {
        [whoTableView setFrame:CGRectMake(whoTableView.frame.origin.x, whoTableView.frame.origin.y, whoTableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [friendsNameAutocompleteArray count]))];
        [whoTableView reloadData];
    }
}

-(void) populateProfileButtons {
    moreFriendsLabel.hidden = YES;
    profileButton1.hidden = NO;
    profileButton2.hidden = NO;
    profileButton3.hidden = NO;
    
    if ([addedFriends count] > 3) {
        moreFriendsLabel.hidden = NO;
        [moreFriendsLabel setText:[NSString stringWithFormat:@"+%i", (int)([addedFriends count] - 3)]];
    } else {
        if ([addedFriends count] == 1) {
            [profileButton1 setTitle:[addedFriends objectAtIndex:0] forState:UIControlStateNormal];
            profileButton2.hidden = YES;
            profileButton3.hidden = YES;
        }
        
        if ([addedFriends count] == 2) {
            [profileButton1 setTitle:[addedFriends objectAtIndex:0] forState:UIControlStateNormal];
            [profileButton2 setTitle:[addedFriends objectAtIndex:1] forState:UIControlStateNormal];
            profileButton3.hidden = YES;
        }
        
        if ([addedFriends count] == 3) {
            [profileButton1 setTitle:[addedFriends objectAtIndex:0] forState:UIControlStateNormal];
            [profileButton2 setTitle:[addedFriends objectAtIndex:1] forState:UIControlStateNormal];
            [profileButton3 setTitle:[addedFriends objectAtIndex:2] forState:UIControlStateNormal];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [addedFriends removeObject:friendToRemove];
            [self populateProfileButtons];
            break;
        case 1:
            //
            break;
        default:
            break;
    }
}

- (IBAction)profileButton1Pressed:(id)sender {
    friendToRemove = profileButton1.titleLabel.text;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Delete Friend?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    actionSheet.tag = 1;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)profileButton2Pressed:(id)sender {
    friendToRemove = profileButton2.titleLabel.text;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Delete Friend?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    actionSheet.tag = 1;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)profileButton3Pressed:(id)sender {
    friendToRemove = profileButton3.titleLabel.text;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Delete Friend?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    actionSheet.tag = 1;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)rideTheWaveHelpButtonPressed:(id)sender {
}

- (IBAction)rideTheWaveOnOffSwitchPressed:(id)sender {
    if (switchOnOrOff == YES) {
        [onOffButton setBackgroundColor:[UIColor blackColor]];
        [onOffButton setTitle:@"off" forState:UIControlStateNormal];
        switchOnOrOff = NO;
    } else {
        [onOffButton setBackgroundColor:[UIColor colorWithRed:5/255.0f green:127/255.0f blue:1/255.0f alpha:1]];
        [onOffButton setTitle:@"on" forState:UIControlStateNormal];
        switchOnOrOff = YES;
    }
}

- (IBAction)rideTheWaveButton1Pressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)rideTheWaveButton2Pressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)openProfileButtonPressed:(id)sender {
}

- (IBAction)gathrButtonPressed:(id)sender {
}

- (IBAction)progressViewButton1Pressed:(id)sender {
    [progressView setProgress:0.2f animated:YES];
    
    [progressViewButton1 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton2 setBackgroundColor:[UIColor whiteColor]];
    [progressViewButton3 setBackgroundColor:[UIColor whiteColor]];
    [progressViewButton4 setBackgroundColor:[UIColor whiteColor]];
    [progressViewButton5 setBackgroundColor:[UIColor whiteColor]];
    
    [progressViewLabel1 setHidden:NO];
    [progressViewLabel2 setHidden:YES];
    [progressViewLabel3 setHidden:YES];
    [progressViewLabel4 setHidden:YES];
}

- (IBAction)progressViewButton2Pressed:(id)sender {
    [progressView setProgress:0.4f animated:YES];
    
    [progressViewButton1 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton2 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton3 setBackgroundColor:[UIColor whiteColor]];
    [progressViewButton4 setBackgroundColor:[UIColor whiteColor]];
    [progressViewButton5 setBackgroundColor:[UIColor whiteColor]];
    
    [progressViewLabel1 setHidden:YES];
    [progressViewLabel2 setHidden:NO];
    [progressViewLabel3 setHidden:YES];
    [progressViewLabel4 setHidden:YES];
}

- (IBAction)progressViewButton3Pressed:(id)sender {
    [progressView setProgress:0.6f animated:YES];
    
    [progressViewButton1 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton2 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton3 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton4 setBackgroundColor:[UIColor whiteColor]];
    [progressViewButton5 setBackgroundColor:[UIColor whiteColor]];
    
    [progressViewLabel1 setHidden:YES];
    [progressViewLabel2 setHidden:YES];
    [progressViewLabel3 setHidden:NO];
    [progressViewLabel4 setHidden:YES];
}

- (IBAction)progressViewButton4Pressed:(id)sender {
    [progressView setProgress:0.8f animated:YES];
    
    [progressViewButton1 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton2 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton3 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton4 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton5 setBackgroundColor:[UIColor whiteColor]];
    
    [progressViewLabel1 setHidden:YES];
    [progressViewLabel2 setHidden:YES];
    [progressViewLabel3 setHidden:YES];
    [progressViewLabel4 setHidden:NO];
}

- (IBAction)progressViewButton5Pressed:(id)sender {
    [progressView setProgress:1.0f animated:YES];
    
    [progressViewButton1 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton2 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton3 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton4 setBackgroundColor:[UIColor orangeColor]];
    [progressViewButton5 setBackgroundColor:[UIColor orangeColor]];
    
    [progressViewLabel1 setHidden:YES];
    [progressViewLabel2 setHidden:YES];
    [progressViewLabel3 setHidden:YES];
    [progressViewLabel4 setHidden:NO];
}

@end
