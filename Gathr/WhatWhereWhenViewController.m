//
//  ViewController.m
//  Gathr
//
//  Created by Poulose Matthen on 13/05/15.
//  Copyright (c) 2015 Zettanode. All rights reserved.
//

// **** Connect dataArray4 to appropriate tableView, shift tableView depending on UILayout ****

#import "WhatWhereWhenViewController.h"
#import "MenuButton1TableViewCell.h"
#import "AutoCompleteTableViewCell.h"
#import "MenuButton2TableViewCell.h"
#import "MenuButton3TableViewCell.h"
#import "WhereMenuButtonTableViewCell.h"
#import "WhereAutoCompleteTableViewCell.h"
#import "WhenMenuButton1TableViewCell.h"
#import "WhenMenuButton2TableViewCell.h"
#import "WhenMenuButton3TableViewCell.h"
#import "WhenMenuButton4TableViewCell.h"

#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"

#define UIELEMENT_ROW1_YVALUE 25
#define UIELEMENT_ROW2_YVALUE 67
#define UIELEMENT_ROW3_YVALUE 109
#define UIELEMENT_ROW4_YVALUE 151

#define BREAKLINELABEL1_POS1_YVALUE 110
#define BREAKLINELABEL1_POS2_YVALUE 152
#define BREAKLINELABEL1_POS3_YVALUE 194

#define WHERELABEL_POS1_YVALUE 158
#define WHERELABEL_POS2_YVALUE 200
#define WHERELABEL_POS3_YVALUE 242

#define BREAKLINELABEL2_POS1_YVALUE 206
#define BREAKLINELABEL2_POS2_YVALUE 248
#define BREAKLINELABEL2_POS3_YVALUE 290

#define WHENLABEL_POS1_YVALUE 258
#define WHENLABEL_POS2_YVALUE 300
#define WHENLABEL_POS3_YVALUE 342
#define WHENLABEL_POS4_YVALUE 384
#define WHENLABEL_POS5_YVALUE 426
#define WHENLABEL_POS6_YVALUE 468

#define TABLEVIEW_MAX_HEIGHT 300
#define TABLEVIEWCELL_ROW_HEIGHT 30

@interface WhatWhereWhenViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, CLLocationManagerDelegate>

@property CLLocation *userLocation;

@property(strong, nonatomic) NSMutableArray *dataArray1; // Used for All Activities List
@property(strong, nonatomic) NSMutableArray *dataArray2; // Used for Games Subcategory
@property(strong, nonatomic) NSMutableArray *dataArray3; // Used for Sports Names Autocomplete
@property(strong, nonatomic) NSMutableArray *dataArray4; // Used for Lower List

@property(strong, nonatomic) NSMutableArray *whereSectionDataArray;

@property(strong, nonatomic) NSMutableArray *whenDataArray1; // Used for Day List
@property(strong, nonatomic) NSMutableArray *whenDataArray2; // Used for At List
@property(strong, nonatomic) NSMutableArray *whenDataArray3; // Used for AM/PM List
@property(strong, nonatomic) NSMutableArray *whenDataArray4; // Used for Duration List

@property(strong, nonatomic) NSMutableArray *autoCompleteArray;
@property BOOL autoCompleteEnabled;

@property (strong, nonatomic) NSMutableArray *placesAutocompleteArray;
@property int placesQueryType;
@property (strong, nonatomic) NSArray *placesArray;

@property (strong, nonatomic) NSString *fieldTextField1Placeholder;
@property (strong, nonatomic) NSString *fieldTextField2Placeholder;
@property (strong, nonatomic) NSString *whereFieldTextPlaceholder;

@property BOOL menuButton1TableViewOpen;
@property BOOL menuButton2TableViewOpen;
@property BOOL menuButton3TableViewOpen;
@property BOOL whereMenuButtonTableViewOpen;
@property BOOL whenMenuButton1TableViewOpen;
@property BOOL whenMenuButton2TableViewOpen;
@property BOOL whenMenuButton3TableViewOpen;
@property BOOL whenMenuButton4TableViewOpen;

@property float menuButton1TableViewYValue;
@property float menuButton2TableViewYValue;
@property float menuButton3TableViewYValue;
@property float whereMenuButtonTableViewYValue;
@property float whereAutoCompleteTableViewYValue;
@property float whenMenuButton1TableViewYValue;
@property float whenMenuButton2TableViewYValue;
@property float whenMenuButton3TableViewYValue;
@property float whenMenuButton4TableViewYValue;

@property int whatMenuButton1Selection;
@property BOOL whenUIElements2Lines;

@end

@implementation WhatWhereWhenViewController
@synthesize whatLabel, whenLabel, whereLabel, breakLineLabel1, breakLineLabel2, menuButton1, menuButton2, fieldTextField1, menuButton3, fieldTextField2, whereMenuButton, whereFieldText, whenMenuButton1, whenMenuButton2, whenMenuButton3, whenMenuButton4, whenFieldText1, whenFieldText2, whenTimeColon, whenDurationLabel, createButton, menuButton1TableView, autoCompleteTableView, menuButton2TableView, menuButton3TableView, whereMenuButtonTableView, whenMenuButton1TableView, whenMenuButton2TableView, whenMenuButton3TableView, whenMenuButton4TableView, menuButton1TableViewOpen, menuButton2TableViewOpen, menuButton3TableViewOpen, whereMenuButtonTableViewOpen, whenMenuButton1TableViewOpen, whenMenuButton2TableViewOpen, whenMenuButton3TableViewOpen, whenMenuButton4TableViewOpen, menuButton1TableViewYValue, menuButton2TableViewYValue, menuButton3TableViewYValue, whereMenuButtonTableViewYValue, whereAutoCompleteTableViewYValue, whenMenuButton1TableViewYValue, whenMenuButton2TableViewYValue, whenMenuButton3TableViewYValue, whenMenuButton4TableViewYValue, whereAutoCompleteTableView, dataArray1, dataArray2, dataArray3, dataArray4, autoCompleteArray, placesAutocompleteArray, placesArray, whereSectionDataArray, whenDataArray1, whenDataArray2, whenDataArray3, whenDataArray4, autoCompleteEnabled, fieldTextField1Placeholder, fieldTextField2Placeholder, whereFieldTextPlaceholder, whenUIElements2Lines, whatMenuButton1Selection, locationManager, userLocation, placesQueryType;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSArray *fontFamilies = [UIFont familyNames];
//    for (int i = 0; i < [fontFamilies count]; i++)
//    {
//        NSString *fontFamily = [fontFamilies objectAtIndex:i];
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
//        NSLog (@"%@: %@", fontFamily, fontNames);
//    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    
    autoCompleteArray = [NSMutableArray new];
    autoCompleteEnabled = NO;
    
    placesAutocompleteArray = [NSMutableArray new];
    placesArray = [NSArray new];
    placesQueryType = 0;
    
    menuButton1TableViewOpen = NO;
    menuButton2TableViewOpen = NO;
    menuButton3TableViewOpen = NO;
    whereMenuButtonTableViewOpen = NO;
    whenMenuButton1TableViewOpen = NO;
    whenMenuButton2TableViewOpen = NO;
    whenMenuButton3TableViewOpen = NO;
    whenMenuButton4TableViewOpen = NO;
    
    whenUIElements2Lines = YES;
    
    menuButton1TableViewYValue = menuButton1TableView.frame.origin.y;
    menuButton2TableViewYValue = menuButton2TableView.frame.origin.y;
    menuButton3TableViewYValue = menuButton3TableView.frame.origin.y;
    whereMenuButtonTableViewYValue = whereMenuButtonTableView.frame.origin.y;
    whereAutoCompleteTableViewYValue = whereAutoCompleteTableView.frame.origin.y;
    whenMenuButton1TableViewYValue = whenMenuButton1TableView.frame.origin.y;
    whenMenuButton2TableViewYValue = whenMenuButton2TableView.frame.origin.y;
    whenMenuButton3TableViewYValue = whenMenuButton3TableView.frame.origin.y;
    whenMenuButton4TableViewYValue = whenMenuButton4TableView.frame.origin.y;
    
    menuButton1TableView.translatesAutoresizingMaskIntoConstraints = NO;
    menuButton1TableView.rowHeight = UITableViewAutomaticDimension;
    menuButton1TableView.tag = 1;
    dataArray1 = [self allActivities_L1];
    
    autoCompleteTableView.translatesAutoresizingMaskIntoConstraints = NO;
    autoCompleteTableView.rowHeight = UITableViewAutomaticDimension;
    autoCompleteTableView.tag = 2;
    
    whereSectionDataArray = [self allPlaces_R2];
    
    whenDataArray1 = [self allDays];
    whenDataArray2 = [self allWhens];
    whenDataArray3 = [self allAMPMs];
    whenDataArray4 = [self allDurations];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [tapGestureRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer setDelegate:self];
    
    menuButton1.titleLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
    menuButton2.titleLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
    menuButton3.titleLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
    fieldTextField1.font = [UIFont fontWithName:@"Karla-Italic" size:18];
    fieldTextField2.font = [UIFont fontWithName:@"Karla-Italic" size:18];
    
    whereMenuButton.titleLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
    whereFieldText.font = [UIFont fontWithName:@"Karla-Italic" size:18];
    
    [self setTextFieldsAndLabelsToAutoAdjustFontSize];
    
    [fieldTextField1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [fieldTextField2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [whereFieldText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    fieldTextField2Placeholder = @"description";
    [fieldTextField2 setPlaceholder:fieldTextField2Placeholder];
    
    if ([fieldTextField2 respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        fieldTextField2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:fieldTextField2Placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    whereFieldTextPlaceholder = @"type a venue/address";
    [whereFieldText setPlaceholder:whereFieldTextPlaceholder];
    
    if ([whereFieldText respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        whereFieldText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:whereFieldTextPlaceholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    whatMenuButton1Selection = 5;
    [self shiftWhatElements:[self determineWhatUIElementLayout:whatMenuButton1Selection]];
    [self shiftWhereElements:[self determineWhereUIElementLayout:1]];
    
    
    
//    "Karla-Italic"
//    "Karla-Bold"
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    userLocation = [locations lastObject];
}

-(void) setTextFieldsAndLabelsToAutoAdjustFontSize {
    menuButton1.titleLabel.adjustsFontSizeToFitWidth = YES;
    menuButton2.titleLabel.adjustsFontSizeToFitWidth = YES;
    menuButton3.titleLabel.adjustsFontSizeToFitWidth = YES;
    fieldTextField1.adjustsFontSizeToFitWidth = YES;
    fieldTextField2.adjustsFontSizeToFitWidth = YES;
    
    whereMenuButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    whereFieldText.adjustsFontSizeToFitWidth = YES;
    
    whenMenuButton1.titleLabel.adjustsFontSizeToFitWidth = YES;
    whenMenuButton2.titleLabel.adjustsFontSizeToFitWidth = YES;
    whenMenuButton3.titleLabel.adjustsFontSizeToFitWidth = YES;
    whenMenuButton4.titleLabel.adjustsFontSizeToFitWidth = YES;
    whenFieldText1.adjustsFontSizeToFitWidth = YES;
    whenFieldText2.adjustsFontSizeToFitWidth = YES;
}

- (NSMutableArray *) allActivities_L1 {
    NSMutableArray *activities = [[NSMutableArray alloc]
                                  initWithArray:@[@"play a sport",
                                                  @"play games",
                                                  @"exert",
                                                  @"watch",
                                                  @"attend",
                                                  @"make/hack",
                                                  @"learn/discuss",
                                                  @"hangout/chill",
                                                  @"step out",
                                                  @"eat",
                                                  @"drink",
                                                  @"shop",
                                                  @"jamming",
                                                  @"playdates",
                                                  @"riding & driving",
                                                  @"health & wellness"]];
    
    return activities;
    
}

- (NSMutableArray *) allSports_L2 {
    NSMutableArray *sports = [[NSMutableArray alloc]
                              initWithArray:@[@"table tennis", @"tennis", @"cricket", @"football (soccer)", @"basketball", @"badminton", @"rugby", @"baseball", @"american football", @"field hockey", @"ice hockey", @"ultimate frisbee", @"golf", @"boxing", @"kickboxing", @"mixed martial arts", @"surfing", @"karate", @"kung fu", @"judo", @"tai kwan do", @"volleyball", @"water polo", @"horse riding", @"polo", @"croquet", @"bowling", @"laser tag", @"paintball", @"skateboarding", @"lacrosse", @"canoeing", @"kayaking", @"kabaddi", @"fencing", @"handball"]];
    
    return sports;
}

- (NSMutableArray *) allGameTypes_L2 {
    NSMutableArray *games = [[NSMutableArray alloc]
                             initWithArray:@[@"board & card games", @"video games"]];
    
    return games;
}

- (NSMutableArray *) allSkillLevels_L3 {
    NSMutableArray *skillLevels = [[NSMutableArray alloc]
                              initWithArray:@[@"all skill levels", @"beginner", @"intermediate", @"advanced"]];
    
    return skillLevels;
}

- (NSMutableArray *) allExertionActivities_L2 {
    NSMutableArray *exertionActivites = [[NSMutableArray alloc] initWithArray:@[@"hike or trek", @"walk", @"jog or run", @"bicycle", @"gym", @"swim", @"sail"]];
    
    return exertionActivites;
}

- (NSMutableArray *) allWatchingActivities_L2 {
    NSMutableArray *watchingActivites = [[NSMutableArray alloc] initWithArray:@[@"a movie", @"sports", @"a play"]];
    
    return watchingActivites;
}

- (NSMutableArray *) allThingsToAttend_L2 {
    NSMutableArray *thingsToAttend = [[NSMutableArray alloc] initWithArray:@[@"a gig", @"a concert", @"a lecture or workshop", @"an art show", @"a fair ", @"a demonstration"]];
    
    return thingsToAttend;
}

- (NSMutableArray *) allStepOutActivities_L2 {
    NSMutableArray *stepOutActivities = [[NSMutableArray alloc] initWithArray:@[@"for a stroll", @"for coffee or tea", @"for juice or ice-cream", @"for a smoke"]];
    
    return stepOutActivities;
}

- (NSMutableArray *) allEatingLocations_L2 {
    NSMutableArray *eatingLocations = [[NSMutableArray alloc] initWithArray:@[@"at home", @"on the street", @"in a restaurant", @"fine dine"]];
    
    return eatingLocations;
}

- (NSMutableArray *) allDrinkingLocations_L2 {
    NSMutableArray *drinkingLocations = [[NSMutableArray alloc] initWithArray:@[@"at a pub", @"at a night club", @"cocktails", @"house party"]];
    
    return drinkingLocations;
}

- (NSMutableArray *) allShoppingLocations_L2 {
    NSMutableArray *shoppingLocations = [[NSMutableArray alloc] initWithArray:@[@"for groceries", @"at the mall", @"on high street"]];
    
    return shoppingLocations;
}

- (NSMutableArray *) allHealthAndWellnessActivities_L2 {
    NSMutableArray *healthAndWellnessActivities = [[NSMutableArray alloc] initWithArray:@[@"yoga", @"meditate", @"tai-chi/chigong"]];
    
    return healthAndWellnessActivities;
}

- (NSMutableArray *) allPlaces_R2 {
    NSMutableArray *places = [[NSMutableArray alloc] initWithArray:@[@"here", @"nearby", @"at", @"in", @"anywhere"]];
    
    return places;
}

- (NSMutableArray *) allDays {
    float dateInterval = (24*60*60);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE"];
    
    NSString *dayString1 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:dateInterval]];
    dateInterval = dateInterval + (24*60*60);
    
    NSString *dayString2 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:dateInterval]];
    dateInterval = dateInterval + (24*60*60);
    
    NSString *dayString3 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:dateInterval]];
    dateInterval = dateInterval + (24*60*60);
    
    NSString *dayString4 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:dateInterval]];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithArray:@[@"today", @"tomorrow", @"day-after", dayString1, dayString2, dayString3, dayString4]];
    
    return days;
}

- (NSMutableArray *) allWhens {
    NSMutableArray *whens = [[NSMutableArray alloc] initWithArray:@[@"anytime", @"now", @"at", @"around", @"after", @"before"]];
    
    return whens;
}

- (NSMutableArray *) allAMPMs {
    NSMutableArray *aMPMs = [[NSMutableArray alloc] initWithArray:@[@"am", @"pm"]];
    
    return aMPMs;
}

- (NSMutableArray *) allDurations {
    NSMutableArray *durations = [[NSMutableArray alloc] initWithArray:@[@"flexible", @"half hour", @"an hour", @"one and a half hours", @"two hours", @"three hours", @"four hours", @"half a day", @"whole day"]];
    
    return durations;
}

// Skill levels for games are the same as skill levels for sports.

- (NSMutableArray *) determineWhatUIElementLayout:(NSInteger)activityIndex {
    
    NSMutableArray *layoutArray = [[NSMutableArray alloc] initWithArray:@[@FALSE, @FALSE, @FALSE, @FALSE, @FALSE]];
    
    fieldTextField2.text = @"";
    [self textFieldDidChange:fieldTextField2];
    
    // An index #0 that is TRUE indicates that the fieldTextField1 autocompletes
    // An index #1 that is TRUE indicates that the second dropdown exists
    // An index #2 that is TRUE indicates that the fieldTextField1 exists
    // An index #3 that is TRUE indicates that the third dropdown exists
    // An index #4 that is TRUE indicates that the fieldTextField2 exists
    
    switch (activityIndex) {
            
        case 0: /* play a sport */
            [layoutArray setObject:@TRUE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@TRUE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            
            fieldTextField1Placeholder = @"type sport name";
            [menuButton3 setTitle:@"skill level" forState:UIControlStateNormal];
            dataArray3 = [self allSports_L2];
            dataArray4 = [self allSkillLevels_L3];
            break;
        case 1: /* play a game */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@TRUE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            
            [menuButton2 setTitle:@"sub-category" forState:UIControlStateNormal];
            [menuButton3 setTitle:@"skill level" forState:UIControlStateNormal];
            dataArray2 = [self allGameTypes_L2];
            dataArray4 = [self allSkillLevels_L3];
            break;
        case 2: /* exert */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];

            fieldTextField1Placeholder = @"";
            [menuButton3 setTitle:@"sub-category" forState:UIControlStateNormal];
            dataArray4 = [self allExertionActivities_L2];
            break;
        case 3:/* watch */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];

            fieldTextField1Placeholder = @"";
            [menuButton3 setTitle:@"sub-category" forState:UIControlStateNormal];
            dataArray4 = [self allWatchingActivities_L2];
            break;
        case 4:/* attend */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            
            fieldTextField1Placeholder = @"";
            [menuButton3 setTitle:@"sub-category" forState:UIControlStateNormal];
            dataArray4 = [self allThingsToAttend_L2];
            break;
        case 5: /* make/hack */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@FALSE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            break;
        case 6: /* learn/discuss */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@FALSE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            break;
        case 7: /* hangout/chill */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@FALSE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            break;
        case 8: /* step out */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            
            fieldTextField1Placeholder = @"";
            [menuButton3 setTitle:@"sub-category" forState:UIControlStateNormal];
            dataArray4 = [self allStepOutActivities_L2];
            break;
        case 9: /* eat */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            
            fieldTextField1Placeholder = @"";
            [menuButton3 setTitle:@"sub-category" forState:UIControlStateNormal];
            dataArray4 = [self allEatingLocations_L2];
            break;
        case 10: /* drink */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            
            fieldTextField1Placeholder = @"";
            [menuButton3 setTitle:@"sub-category" forState:UIControlStateNormal];
            dataArray4 = [self allDrinkingLocations_L2];
            break;
        case 11: /* shop */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            
            fieldTextField1Placeholder = @"";
            [menuButton3 setTitle:@"sub-category" forState:UIControlStateNormal];
            dataArray4 = [self allShoppingLocations_L2];
            break;
        case 12: /* jamming */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            
            [menuButton3 setTitle:@"skill level" forState:UIControlStateNormal];
            dataArray4 = [self allSkillLevels_L3];
            break;
        case 13: /* playdates */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@FALSE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            break;
        case 14: /* riding & driving */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@FALSE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            break;
        case 15: /* health & wellness */
            [layoutArray setObject:@FALSE atIndexedSubscript:0];
            [layoutArray setObject:@FALSE atIndexedSubscript:1];
            [layoutArray setObject:@FALSE atIndexedSubscript:2];
            [layoutArray setObject:@TRUE atIndexedSubscript:3];
            [layoutArray setObject:@TRUE atIndexedSubscript:4];
            
            fieldTextField1Placeholder = @"";
            [menuButton3 setTitle:@"sub-category" forState:UIControlStateNormal];
            dataArray4 = [self allHealthAndWellnessActivities_L2];
            break;

        default:
            break;
    }
    
    [menuButton1TableView reloadData];
    [autoCompleteTableView reloadData];
    [menuButton2TableView reloadData];
    [menuButton3TableView reloadData];
    
    return layoutArray;
    
}

-(void) shiftWhatElements:(NSMutableArray *)layoutArray {
    // An index #0 that is TRUE indicates that the fieldTextField1 autocompletes
    // An index #1 that is TRUE indicates that the second dropdown exists
    // An index #2 that is TRUE indicates that the fieldTextField1 exists
    // An index #3 that is TRUE indicates that the third dropdown exists
    // An index #4 that is TRUE indicates that the fieldTextField2 exists
    
    if ([layoutArray isEqualToArray:@[@TRUE, @TRUE, @TRUE, @TRUE, @TRUE]]) {
        // DOESN'T EXIST
    }
    
    if ([layoutArray isEqualToArray:@[@FALSE, @TRUE, @TRUE, @TRUE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @FALSE, @TRUE, @TRUE, @TRUE]]) {
        // EXISTS (play a sport)

        autoCompleteEnabled = YES;
        
        [menuButton2 setHidden:TRUE];
        [fieldTextField1 setHidden:FALSE];
        [autoCompleteTableView setHidden:TRUE];
        [menuButton3 setHidden:FALSE];
        [fieldTextField2 setHidden:FALSE];
        [whenMenuButton3 setHidden:FALSE];
        [whenFieldText1 setHidden:FALSE];
        [whenFieldText2 setHidden:FALSE];
        [whenTimeColon setHidden:FALSE];
        
        if ([fieldTextField1 respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor whiteColor];
            fieldTextField1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:fieldTextField1Placeholder attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        }
        
        if ([fieldTextField2 respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor whiteColor];
            fieldTextField2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:fieldTextField2Placeholder attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        }
        
        whereLabel.frame = CGRectMake(whereLabel.frame.origin.x, WHERELABEL_POS3_YVALUE, whereLabel.frame.size.width, whereLabel.frame.size.height);
        whereMenuButton.frame = CGRectMake(whereMenuButton.frame.origin.x, WHERELABEL_POS3_YVALUE, whereMenuButton.frame.size.width, whereMenuButton.frame.size.height);
        whereFieldText.frame = CGRectMake(whereFieldText.frame.origin.x, WHERELABEL_POS3_YVALUE, whereFieldText.frame.size.width, whereFieldText.frame.size.height);
        
        whenLabel.frame = CGRectMake(whenLabel.frame.origin.x, WHENLABEL_POS3_YVALUE, whenLabel.frame.size.width, whenLabel.frame.size.height);
        whenMenuButton1.frame = CGRectMake(whenMenuButton1.frame.origin.x, WHENLABEL_POS3_YVALUE, whenMenuButton1.frame.size.width, whenMenuButton1.frame.size.height);
        whenMenuButton2.frame = CGRectMake(whenMenuButton2.frame.origin.x, WHENLABEL_POS3_YVALUE, whenMenuButton2.frame.size.width, whenMenuButton2.frame.size.height);
        whenMenuButton3.frame = CGRectMake(whenMenuButton3.frame.origin.x, WHENLABEL_POS4_YVALUE, whenMenuButton3.frame.size.width, whenMenuButton3.frame.size.height);
        whenMenuButton4.frame = CGRectMake(whenMenuButton4.frame.origin.x, WHENLABEL_POS5_YVALUE, whenMenuButton4.frame.size.width, whenMenuButton4.frame.size.height);
        whenTimeColon.frame = CGRectMake(whenTimeColon.frame.origin.x, WHENLABEL_POS4_YVALUE, whenTimeColon.frame.size.width, whenTimeColon.frame.size.height);
        whenFieldText1.frame = CGRectMake(whenFieldText1.frame.origin.x, WHENLABEL_POS4_YVALUE, whenFieldText1.frame.size.width, whenFieldText1.frame.size.height);
        whenFieldText2.frame = CGRectMake(whenFieldText2.frame.origin.x, WHENLABEL_POS4_YVALUE, whenFieldText2.frame.size.width, whenFieldText2.frame.size.height);
        whenDurationLabel.frame = CGRectMake(whenDurationLabel.frame.origin.x, WHENLABEL_POS5_YVALUE, whenDurationLabel.frame.size.width, whenDurationLabel.frame.size.height);
        
        createButton.frame = CGRectMake(createButton.frame.origin.x, WHENLABEL_POS6_YVALUE, createButton.frame.size.width, createButton.frame.size.height);
        
        if (whenUIElements2Lines) {
            [whenMenuButton3 setHidden:TRUE];
            [whenFieldText1 setHidden:TRUE];
            [whenFieldText2 setHidden:TRUE];
            [whenTimeColon setHidden:TRUE];
            
            whenMenuButton4.frame = CGRectMake(whenMenuButton4.frame.origin.x, WHENLABEL_POS4_YVALUE, whenMenuButton4.frame.size.width, whenMenuButton4.frame.size.height);
            whenDurationLabel.frame = CGRectMake(whenDurationLabel.frame.origin.x, WHENLABEL_POS4_YVALUE, whenDurationLabel.frame.size.width, whenDurationLabel.frame.size.height);
            
            createButton.frame = CGRectMake(createButton.frame.origin.x, WHENLABEL_POS5_YVALUE, createButton.frame.size.width, createButton.frame.size.height);
        }
        
        breakLineLabel1.frame = CGRectMake(breakLineLabel1.frame.origin.x, BREAKLINELABEL1_POS3_YVALUE, breakLineLabel1.frame.size.width, breakLineLabel1.frame.size.height);
        breakLineLabel2.frame = CGRectMake(breakLineLabel2.frame.origin.x, BREAKLINELABEL2_POS3_YVALUE, breakLineLabel2.frame.size.width, breakLineLabel2.frame.size.height);
        
        menuButton1.frame = CGRectMake(menuButton1.frame.origin.x, UIELEMENT_ROW1_YVALUE, menuButton1.frame.size.width, menuButton1.frame.size.height);
        fieldTextField1.frame = CGRectMake(fieldTextField1.frame.origin.x, UIELEMENT_ROW2_YVALUE, fieldTextField1.frame.size.width, fieldTextField1.frame.size.height);
        menuButton3.frame = CGRectMake(menuButton3.frame.origin.x, UIELEMENT_ROW3_YVALUE, menuButton3.frame.size.width, menuButton3.frame.size.height);
        fieldTextField2.frame = CGRectMake(fieldTextField2.frame.origin.x, UIELEMENT_ROW4_YVALUE, fieldTextField2.frame.size.width, fieldTextField2.frame.size.height);
        
        menuButton1TableViewYValue = menuButton1.frame.origin.y + 34;
        menuButton3TableViewYValue = menuButton3.frame.origin.y + 34;
        
        whereMenuButtonTableViewYValue = whereMenuButton.frame.origin.y + 34;
        whereAutoCompleteTableViewYValue = whereFieldText.frame.origin.y + 34;
        whenMenuButton1TableViewYValue = whenMenuButton1.frame.origin.y + 34;
        whenMenuButton2TableViewYValue = whenMenuButton2.frame.origin.y + 34;
        whenMenuButton3TableViewYValue = whenMenuButton3.frame.origin.y + 34;
        whenMenuButton4TableViewYValue = whenMenuButton4.frame.origin.y + 34;
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @TRUE, @FALSE, @TRUE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @TRUE, @TRUE, @FALSE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @TRUE, @TRUE, @TRUE, @FALSE]]) {
        // DOESN'T EXIST
    }
    
    if ([layoutArray isEqualToArray:@[@FALSE, @FALSE, @TRUE, @TRUE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @TRUE, @FALSE, @TRUE, @TRUE]]) {
        // EXISTS (play a game)
        
        autoCompleteEnabled = NO;
        
        [menuButton1 setHidden:FALSE];
        [menuButton2 setHidden:FALSE];
        [fieldTextField1 setHidden:TRUE];
        [autoCompleteTableView setHidden:FALSE];
        [menuButton3 setHidden:FALSE];
        [fieldTextField2 setHidden:FALSE];
        [whenMenuButton3 setHidden:FALSE];
        [whenFieldText1 setHidden:FALSE];
        [whenFieldText2 setHidden:FALSE];
        [whenTimeColon setHidden:FALSE];
        
        if ([fieldTextField2 respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor whiteColor];
            fieldTextField2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:fieldTextField2Placeholder attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        }
        
        whereLabel.frame = CGRectMake(whereLabel.frame.origin.x, WHERELABEL_POS3_YVALUE, whereLabel.frame.size.width, whereLabel.frame.size.height);
        whereMenuButton.frame = CGRectMake(whereMenuButton.frame.origin.x, WHERELABEL_POS3_YVALUE, whereMenuButton.frame.size.width, whereMenuButton.frame.size.height);
        whereFieldText.frame = CGRectMake(whereFieldText.frame.origin.x, WHERELABEL_POS3_YVALUE, whereFieldText.frame.size.width, whereFieldText.frame.size.height);
        
        whenLabel.frame = CGRectMake(whenLabel.frame.origin.x, WHENLABEL_POS3_YVALUE, whenLabel.frame.size.width, whenLabel.frame.size.height);
        whenMenuButton1.frame = CGRectMake(whenMenuButton1.frame.origin.x, WHENLABEL_POS3_YVALUE, whenMenuButton1.frame.size.width, whenMenuButton1.frame.size.height);
        whenMenuButton2.frame = CGRectMake(whenMenuButton2.frame.origin.x, WHENLABEL_POS3_YVALUE, whenMenuButton2.frame.size.width, whenMenuButton2.frame.size.height);
        whenMenuButton3.frame = CGRectMake(whenMenuButton3.frame.origin.x, WHENLABEL_POS4_YVALUE, whenMenuButton3.frame.size.width, whenMenuButton3.frame.size.height);
        whenMenuButton4.frame = CGRectMake(whenMenuButton4.frame.origin.x, WHENLABEL_POS5_YVALUE, whenMenuButton4.frame.size.width, whenMenuButton4.frame.size.height);
        whenTimeColon.frame = CGRectMake(whenTimeColon.frame.origin.x, WHENLABEL_POS4_YVALUE, whenTimeColon.frame.size.width, whenTimeColon.frame.size.height);
        whenFieldText1.frame = CGRectMake(whenFieldText1.frame.origin.x, WHENLABEL_POS4_YVALUE, whenFieldText1.frame.size.width, whenFieldText1.frame.size.height);
        whenFieldText2.frame = CGRectMake(whenFieldText2.frame.origin.x, WHENLABEL_POS4_YVALUE, whenFieldText2.frame.size.width, whenFieldText2.frame.size.height);
        whenDurationLabel.frame = CGRectMake(whenDurationLabel.frame.origin.x, WHENLABEL_POS5_YVALUE, whenDurationLabel.frame.size.width, whenDurationLabel.frame.size.height);
        
        
        createButton.frame = CGRectMake(createButton.frame.origin.x, WHENLABEL_POS6_YVALUE, createButton.frame.size.width, createButton.frame.size.height);
        
        if (whenUIElements2Lines) {
            [whenMenuButton3 setHidden:TRUE];
            [whenFieldText1 setHidden:TRUE];
            [whenFieldText2 setHidden:TRUE];
            [whenTimeColon setHidden:TRUE];
            
            whenMenuButton4.frame = CGRectMake(whenMenuButton4.frame.origin.x, WHENLABEL_POS4_YVALUE, whenMenuButton4.frame.size.width, whenMenuButton4.frame.size.height);
            whenDurationLabel.frame = CGRectMake(whenDurationLabel.frame.origin.x, WHENLABEL_POS4_YVALUE, whenDurationLabel.frame.size.width, whenDurationLabel.frame.size.height);
            
            createButton.frame = CGRectMake(createButton.frame.origin.x, WHENLABEL_POS5_YVALUE, createButton.frame.size.width, createButton.frame.size.height);
        }
        
        breakLineLabel1.frame = CGRectMake(breakLineLabel1.frame.origin.x, BREAKLINELABEL1_POS3_YVALUE, breakLineLabel1.frame.size.width, breakLineLabel1.frame.size.height);
        breakLineLabel2.frame = CGRectMake(breakLineLabel2.frame.origin.x, BREAKLINELABEL2_POS3_YVALUE, breakLineLabel2.frame.size.width, breakLineLabel2.frame.size.height);
        
        menuButton1.frame = CGRectMake(menuButton1.frame.origin.x, UIELEMENT_ROW1_YVALUE, menuButton1.frame.size.width, menuButton1.frame.size.height);
        menuButton2.frame = CGRectMake(menuButton2.frame.origin.x, UIELEMENT_ROW2_YVALUE, menuButton2.frame.size.width, menuButton2.frame.size.height);
        menuButton3.frame = CGRectMake(menuButton3.frame.origin.x, UIELEMENT_ROW3_YVALUE, menuButton3.frame.size.width, menuButton3.frame.size.height);
        fieldTextField2.frame = CGRectMake(fieldTextField2.frame.origin.x, UIELEMENT_ROW4_YVALUE, fieldTextField2.frame.size.width, fieldTextField2.frame.size.height);
        
        menuButton1TableViewYValue = menuButton1.frame.origin.y + 34;
        menuButton2TableViewYValue = menuButton2.frame.origin.y + 34;
        menuButton3TableViewYValue = menuButton3.frame.origin.y + 34;
        whereMenuButtonTableViewYValue = whereMenuButton.frame.origin.y + 34;
        whereAutoCompleteTableViewYValue = whereFieldText.frame.origin.y + 34;
        whenMenuButton1TableViewYValue = whenMenuButton1.frame.origin.y + 34;
        whenMenuButton2TableViewYValue = whenMenuButton2.frame.origin.y + 34;
        whenMenuButton3TableViewYValue = whenMenuButton3.frame.origin.y + 34;
        whenMenuButton4TableViewYValue = whenMenuButton4.frame.origin.y + 34;
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @TRUE, @TRUE, @FALSE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @TRUE, @TRUE, @TRUE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @FALSE, @FALSE, @TRUE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @FALSE, @TRUE, @FALSE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @FALSE, @TRUE, @TRUE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @TRUE, @FALSE, @FALSE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @TRUE, @FALSE, @TRUE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @TRUE, @TRUE, @FALSE, @FALSE]]) {
        // DOESN'T EXIST
    }
    
    if ([layoutArray isEqualToArray:@[@FALSE, @FALSE, @FALSE, @TRUE, @TRUE]]) {
        // EXISTS (exert, watch, attend, step out, eat, drink, shop, jamming, health & wellness)

        autoCompleteEnabled = NO;
        
        [menuButton1 setHidden:FALSE];
        [menuButton2 setHidden:TRUE];
        [fieldTextField1 setHidden:TRUE];
        [autoCompleteTableView setHidden:TRUE];
        [menuButton3 setHidden:FALSE];
        [fieldTextField2 setHidden:FALSE];
        [whenMenuButton3 setHidden:FALSE];
        [whenFieldText1 setHidden:FALSE];
        [whenFieldText2 setHidden:FALSE];
        [whenTimeColon setHidden:FALSE];
        
        if ([fieldTextField2 respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor whiteColor];
            fieldTextField2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:fieldTextField2Placeholder attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        }
        
        whereLabel.frame = CGRectMake(whereLabel.frame.origin.x, WHERELABEL_POS2_YVALUE, whereLabel.frame.size.width, whereLabel.frame.size.height);
        whereMenuButton.frame = CGRectMake(whereMenuButton.frame.origin.x, WHERELABEL_POS2_YVALUE, whereMenuButton.frame.size.width, whereMenuButton.frame.size.height);
        whereFieldText.frame = CGRectMake(whereFieldText.frame.origin.x, WHERELABEL_POS2_YVALUE, whereFieldText.frame.size.width, whereFieldText.frame.size.height);
        
        whenLabel.frame = CGRectMake(whenLabel.frame.origin.x, WHENLABEL_POS2_YVALUE, whenLabel.frame.size.width, whenLabel.frame.size.height);
        whenMenuButton1.frame = CGRectMake(whenMenuButton1.frame.origin.x, WHENLABEL_POS2_YVALUE, whenMenuButton1.frame.size.width, whenMenuButton1.frame.size.height);
        whenMenuButton2.frame = CGRectMake(whenMenuButton2.frame.origin.x, WHENLABEL_POS2_YVALUE, whenMenuButton2.frame.size.width, whenMenuButton2.frame.size.height);
        whenMenuButton3.frame = CGRectMake(whenMenuButton3.frame.origin.x, WHENLABEL_POS3_YVALUE, whenMenuButton3.frame.size.width, whenMenuButton3.frame.size.height);
        whenMenuButton4.frame = CGRectMake(whenMenuButton4.frame.origin.x, WHENLABEL_POS4_YVALUE, whenMenuButton4.frame.size.width, whenMenuButton4.frame.size.height);
        whenTimeColon.frame = CGRectMake(whenTimeColon.frame.origin.x, WHENLABEL_POS3_YVALUE, whenTimeColon.frame.size.width, whenTimeColon.frame.size.height);
        whenFieldText1.frame = CGRectMake(whenFieldText1.frame.origin.x, WHENLABEL_POS3_YVALUE, whenFieldText1.frame.size.width, whenFieldText1.frame.size.height);
        whenFieldText2.frame = CGRectMake(whenFieldText2.frame.origin.x, WHENLABEL_POS3_YVALUE, whenFieldText2.frame.size.width, whenFieldText2.frame.size.height);
        whenDurationLabel.frame = CGRectMake(whenDurationLabel.frame.origin.x, WHENLABEL_POS4_YVALUE, whenDurationLabel.frame.size.width, whenDurationLabel.frame.size.height);
        
        createButton.frame = CGRectMake(createButton.frame.origin.x, WHENLABEL_POS5_YVALUE, createButton.frame.size.width, createButton.frame.size.height);
        
        if (whenUIElements2Lines) {
            [whenMenuButton3 setHidden:TRUE];
            [whenFieldText1 setHidden:TRUE];
            [whenFieldText2 setHidden:TRUE];
            [whenTimeColon setHidden:TRUE];
            
            whenMenuButton4.frame = CGRectMake(whenMenuButton4.frame.origin.x, WHENLABEL_POS3_YVALUE, whenMenuButton4.frame.size.width, whenMenuButton4.frame.size.height);
            whenDurationLabel.frame = CGRectMake(whenDurationLabel.frame.origin.x, WHENLABEL_POS3_YVALUE, whenDurationLabel.frame.size.width, whenDurationLabel.frame.size.height);
            
            createButton.frame = CGRectMake(createButton.frame.origin.x, WHENLABEL_POS4_YVALUE, createButton.frame.size.width, createButton.frame.size.height);
        }
        
        breakLineLabel1.frame = CGRectMake(breakLineLabel1.frame.origin.x, BREAKLINELABEL1_POS2_YVALUE, breakLineLabel1.frame.size.width, breakLineLabel1.frame.size.height);
        breakLineLabel2.frame = CGRectMake(breakLineLabel2.frame.origin.x, BREAKLINELABEL2_POS2_YVALUE, breakLineLabel2.frame.size.width, breakLineLabel2.frame.size.height);
        
        menuButton1.frame = CGRectMake(menuButton1.frame.origin.x, UIELEMENT_ROW1_YVALUE, menuButton1.frame.size.width, menuButton1.frame.size.height);
        menuButton3.frame = CGRectMake(menuButton3.frame.origin.x, UIELEMENT_ROW2_YVALUE, menuButton3.frame.size.width, menuButton3.frame.size.height);
        fieldTextField2.frame = CGRectMake(fieldTextField2.frame.origin.x, UIELEMENT_ROW3_YVALUE, fieldTextField2.frame.size.width, fieldTextField2.frame.size.height);
        
        menuButton1TableViewYValue = menuButton1.frame.origin.y + 34;
        menuButton3TableViewYValue = menuButton3.frame.origin.y + 34;
        whereMenuButtonTableViewYValue = whereMenuButton.frame.origin.y + 34;
        whereAutoCompleteTableViewYValue = whereFieldText.frame.origin.y + 34;
        whenMenuButton1TableViewYValue = whenMenuButton1.frame.origin.y + 34;
        whenMenuButton2TableViewYValue = whenMenuButton2.frame.origin.y + 34;
        whenMenuButton3TableViewYValue = whenMenuButton3.frame.origin.y + 34;
        whenMenuButton4TableViewYValue = whenMenuButton4.frame.origin.y + 34;
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @FALSE, @TRUE, @FALSE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @FALSE, @TRUE, @TRUE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @TRUE, @FALSE, @FALSE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @TRUE, @FALSE, @TRUE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @TRUE, @TRUE, @FALSE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @FALSE, @FALSE, @FALSE, @TRUE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @FALSE, @FALSE, @TRUE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @FALSE, @TRUE, @FALSE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @TRUE, @FALSE, @FALSE, @FALSE]]) {
        // DOESN'T EXIST
    }
    
    if ([layoutArray isEqualToArray:@[@FALSE, @FALSE, @FALSE, @FALSE, @TRUE]]) {
        // EXISTS (make/hack, learn/discuss, hangout/chill, playdates, riding & driving)
        
        autoCompleteEnabled = NO;
        
        [menuButton1 setHidden:FALSE];
        [menuButton2 setHidden:TRUE];
        [fieldTextField1 setHidden:TRUE];
        [autoCompleteTableView setHidden:TRUE];
        [fieldTextField2 setHidden:FALSE];
        [menuButton3 setHidden:TRUE];
        [whenMenuButton3 setHidden:FALSE];
        [whenFieldText1 setHidden:FALSE];
        [whenFieldText2 setHidden:FALSE];
        [whenTimeColon setHidden:FALSE];
        
        whereLabel.frame = CGRectMake(whereLabel.frame.origin.x, WHERELABEL_POS1_YVALUE, whereLabel.frame.size.width, whereLabel.frame.size.height);
        whereMenuButton.frame = CGRectMake(whereMenuButton.frame.origin.x, WHERELABEL_POS1_YVALUE, whereMenuButton.frame.size.width, whereMenuButton.frame.size.height);
        whereFieldText.frame = CGRectMake(whereFieldText.frame.origin.x, WHERELABEL_POS1_YVALUE, whereFieldText.frame.size.width, whereFieldText.frame.size.height);
        
        whenLabel.frame = CGRectMake(whenLabel.frame.origin.x, WHENLABEL_POS1_YVALUE, whenLabel.frame.size.width, whenLabel.frame.size.height);
        whenMenuButton1.frame = CGRectMake(whenMenuButton1.frame.origin.x, WHENLABEL_POS1_YVALUE, whenMenuButton1.frame.size.width, whenMenuButton1.frame.size.height);
        whenMenuButton2.frame = CGRectMake(whenMenuButton2.frame.origin.x, WHENLABEL_POS1_YVALUE, whenMenuButton2.frame.size.width, whenMenuButton2.frame.size.height);
        whenMenuButton3.frame = CGRectMake(whenMenuButton3.frame.origin.x, WHENLABEL_POS2_YVALUE, whenMenuButton3.frame.size.width, whenMenuButton3.frame.size.height);
        whenMenuButton4.frame = CGRectMake(whenMenuButton4.frame.origin.x, WHENLABEL_POS3_YVALUE, whenMenuButton4.frame.size.width, whenMenuButton4.frame.size.height);
        whenTimeColon.frame = CGRectMake(whenTimeColon.frame.origin.x, WHENLABEL_POS2_YVALUE, whenTimeColon.frame.size.width, whenTimeColon.frame.size.height);
        whenFieldText1.frame = CGRectMake(whenFieldText1.frame.origin.x, WHENLABEL_POS2_YVALUE, whenFieldText1.frame.size.width, whenFieldText1.frame.size.height);
        whenFieldText2.frame = CGRectMake(whenFieldText2.frame.origin.x, WHENLABEL_POS2_YVALUE, whenFieldText2.frame.size.width, whenFieldText2.frame.size.height);
        whenDurationLabel.frame = CGRectMake(whenDurationLabel.frame.origin.x, WHENLABEL_POS3_YVALUE, whenDurationLabel.frame.size.width, whenDurationLabel.frame.size.height);
        
        createButton.frame = CGRectMake(createButton.frame.origin.x, WHENLABEL_POS4_YVALUE, createButton.frame.size.width, createButton.frame.size.height);
        
        if (whenUIElements2Lines) {
            [whenMenuButton3 setHidden:TRUE];
            [whenFieldText1 setHidden:TRUE];
            [whenFieldText2 setHidden:TRUE];
            [whenTimeColon setHidden:TRUE];
            
            whenMenuButton4.frame = CGRectMake(whenMenuButton4.frame.origin.x, WHENLABEL_POS2_YVALUE, whenMenuButton4.frame.size.width, whenMenuButton4.frame.size.height);
            whenDurationLabel.frame = CGRectMake(whenDurationLabel.frame.origin.x, WHENLABEL_POS2_YVALUE, whenDurationLabel.frame.size.width, whenDurationLabel.frame.size.height);
            
            createButton.frame = CGRectMake(createButton.frame.origin.x, WHENLABEL_POS3_YVALUE, createButton.frame.size.width, createButton.frame.size.height);
        }
        
        breakLineLabel1.frame = CGRectMake(breakLineLabel1.frame.origin.x, BREAKLINELABEL1_POS1_YVALUE, breakLineLabel1.frame.size.width, breakLineLabel1.frame.size.height);
        breakLineLabel2.frame = CGRectMake(breakLineLabel2.frame.origin.x, BREAKLINELABEL2_POS1_YVALUE, breakLineLabel2.frame.size.width, breakLineLabel2.frame.size.height);
        
        menuButton1.frame = CGRectMake(menuButton1.frame.origin.x, UIELEMENT_ROW1_YVALUE, menuButton1.frame.size.width, menuButton1.frame.size.height);
        fieldTextField2.frame = CGRectMake(fieldTextField2.frame.origin.x, UIELEMENT_ROW2_YVALUE, fieldTextField2.frame.size.width, fieldTextField2.frame.size.height);
        
        menuButton1TableViewYValue = menuButton1.frame.origin.y + 34;
        whereMenuButtonTableViewYValue = whereMenuButton.frame.origin.y + 34;
        whereAutoCompleteTableViewYValue = whereFieldText.frame.origin.y + 34;
        whenMenuButton1TableViewYValue = whenMenuButton1.frame.origin.y + 34;
        whenMenuButton2TableViewYValue = whenMenuButton2.frame.origin.y + 34;
        whenMenuButton3TableViewYValue = whenMenuButton3.frame.origin.y + 34;
        whenMenuButton4TableViewYValue = whenMenuButton4.frame.origin.y + 34;
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @FALSE, @FALSE, @TRUE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @FALSE, @TRUE, @FALSE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@FALSE, @TRUE, @FALSE, @FALSE, @FALSE]]) {
        // DOESN'T EXIST
    }
    if ([layoutArray isEqualToArray:@[@TRUE, @FALSE, @FALSE, @FALSE, @FALSE]]) {
        // DOESN'T EXIST
    }
    
    if ([layoutArray isEqualToArray:@[@FALSE, @FALSE, @FALSE, @FALSE, @FALSE]]) {
        // DOESN'T EXIST
    }
}

- (NSMutableArray *) determineWhereUIElementLayout:(NSInteger)activityIndex {
    NSMutableArray *layoutArray = [[NSMutableArray alloc] initWithArray:@[@FALSE, @FALSE, @FALSE, @FALSE, @FALSE]];
    
    whereFieldText.text = @"";
    [self textFieldDidChange:whereFieldText];
    
    // An index #0 that is TRUE indicates the users current location is stored
    // An index #1 that is TRUE indicates the users current location is stored and used to define what nearbye means
    // An index #2 that is TRUE indicates that the autocomplete fieldText is shown and used to search for venues/addresses
    // An index #3 that is TRUE indicates that the autocomplete fieldText is shown and used to search for localities/neigborhoods
    // An index #4 that is TRUE indicates no location is stored
    
    [layoutArray setObject:@TRUE atIndexedSubscript:activityIndex];
    
    return layoutArray;
}

-(void) shiftWhereElements:(NSMutableArray *)layoutArray {
    // An index #0 that is TRUE indicates the users current location is stored
    // An index #1 that is TRUE indicates the users current location is stored and used to define what nearbye means
    // An index #2 that is TRUE indicates that the autocompete fieldText is shown and used to search for venues/addresses
    // An index #3 that is TRUE indicates that the autocompete fieldText is shown and used to search for localities/neigborhoods
    // An index #4 that is TRUE indicates no location is stored
    
    if ([layoutArray[0]  isEqual: @TRUE]) {
        // Save users current location
        whereFieldText.hidden = TRUE;
    }
    
    if ([layoutArray[1]  isEqual: @TRUE]) {
        // Save users current location and use it to define what nearbye means
        whereFieldText.hidden = TRUE;
    }
    
    if ([layoutArray[2]  isEqual: @TRUE]) {
        placesQueryType = 1;
        whereFieldText.hidden = FALSE;
        
        if ([whereFieldText respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor whiteColor];
            whereFieldText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:whereFieldTextPlaceholder attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        }
    }
    
    if ([layoutArray[3]  isEqual: @TRUE]) {
        placesQueryType = 0;
        whereFieldText.hidden = FALSE;
        
        if ([whereFieldText respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor whiteColor];
            whereFieldText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:whereFieldTextPlaceholder attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        }
    }
    
    if ([layoutArray[4]  isEqual: @TRUE]) {
        // No location is stored
        whereFieldText.hidden = TRUE;
    }
}

-(void) shiftWhenElements:(BOOL)timeSectionExists {
    whenUIElements2Lines = !timeSectionExists;
    [self shiftWhatElements:[self determineWhatUIElementLayout:whatMenuButton1Selection]];
}

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer {
    for (UITextField *myTextField in self.view.subviews) {
        [myTextField resignFirstResponder];
    }
}

-(void) showHideDropdown:(UITableView *)sender {
    [autoCompleteTableView setFrame:CGRectMake(autoCompleteTableView.frame.origin.x, autoCompleteTableView.frame.origin.y , autoCompleteTableView.frame.size.width, 0)];
    autoCompleteTableView.hidden = YES;
    
    [menuButton1TableView setFrame:CGRectMake(menuButton1TableView.frame.origin.x, menuButton1TableView.frame.origin.y , menuButton1TableView.frame.size.width, 0)];
    menuButton1TableView.hidden = YES;
    
    [menuButton2TableView setFrame:CGRectMake(menuButton2TableView.frame.origin.x, menuButton2TableView.frame.origin.y , menuButton2TableView.frame.size.width, 0)];
    menuButton2TableView.hidden = YES;
    
    [menuButton3TableView setFrame:CGRectMake(menuButton3TableView.frame.origin.x, menuButton3TableView.frame.origin.y , menuButton3TableView.frame.size.width, 0)];
    menuButton3TableView.hidden = YES;
    
    [whereMenuButtonTableView setFrame:CGRectMake(whereMenuButtonTableView.frame.origin.x, whereMenuButtonTableView.frame.origin.y , whereMenuButtonTableView.frame.size.width, 0)];
    whereMenuButtonTableView.hidden = YES;
    
    [whereAutoCompleteTableView setFrame:CGRectMake(whereAutoCompleteTableView.frame.origin.x, whereAutoCompleteTableViewYValue, whereAutoCompleteTableView.frame.size.width, 0)];
    whereAutoCompleteTableView.hidden = YES;
    
    [whenMenuButton1TableView setFrame:CGRectMake(whenMenuButton1TableView.frame.origin.x, whenMenuButton1TableView.frame.origin.y , whenMenuButton1TableView.frame.size.width, 0)];
    whenMenuButton1TableView.hidden = YES;

    [whenMenuButton2TableView setFrame:CGRectMake(whenMenuButton2TableView.frame.origin.x, whenMenuButton2TableView.frame.origin.y , whenMenuButton2TableView.frame.size.width, 0)];
    whenMenuButton2TableView.hidden = YES;
    
    [whenMenuButton3TableView setFrame:CGRectMake(whenMenuButton3TableView.frame.origin.x, whenMenuButton3TableView.frame.origin.y , whenMenuButton3TableView.frame.size.width, 0)];
    whenMenuButton3TableView.hidden = YES;
    
    [whenMenuButton4TableView setFrame:CGRectMake(whenMenuButton4TableView.frame.origin.x, whenMenuButton4TableView.frame.origin.y , whenMenuButton4TableView.frame.size.width, 0)];
    whenMenuButton4TableView.hidden = YES;
    
    if (sender.tag == 1) {
        if (menuButton1TableViewOpen == NO) {
            [self.view bringSubviewToFront:menuButton1TableView];
            menuButton1TableViewOpen = YES;
            menuButton1TableView.hidden = NO;
            [menuButton1TableView setFrame:CGRectMake(menuButton1TableView.frame.origin.x, menuButton1TableViewYValue + 1, menuButton1TableView.frame.size.width, menuButton1TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [menuButton1TableView setFrame:CGRectMake(menuButton1TableView.frame.origin.x, menuButton1TableView.frame.origin.y, menuButton1TableView.frame.size.width, 200)];
            [UIView commitAnimations];
        }
        
        else if (menuButton1TableViewOpen == YES) {
            menuButton1TableViewOpen = NO;
            [menuButton1TableView setFrame:CGRectMake(menuButton1TableView.frame.origin.x, menuButton1TableViewYValue, menuButton1TableView.frame.size.width, menuButton1TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [menuButton1TableView setFrame:CGRectMake(menuButton1TableView.frame.origin.x, menuButton1TableView.frame.origin.y , menuButton1TableView.frame.size.width, 0)];
            menuButton1TableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
    
    if (sender.tag == 2) {
        if (menuButton2TableViewOpen == NO) {
            [self.view bringSubviewToFront:menuButton2TableView];
            menuButton2TableViewOpen = YES;
            menuButton2TableView.hidden = NO;
            [menuButton2TableView setFrame:CGRectMake(menuButton2TableView.frame.origin.x, menuButton2TableViewYValue + 1, menuButton2TableView.frame.size.width, menuButton2TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            if ([dataArray2 count] >= 10) {
                [menuButton2TableView setFrame:CGRectMake(menuButton2TableView.frame.origin.x, menuButton2TableView.frame.origin.y, menuButton2TableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [menuButton2TableView reloadData];
                });
            } else {
                [menuButton2TableView setFrame:CGRectMake(menuButton2TableView.frame.origin.x, menuButton2TableView.frame.origin.y, menuButton2TableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [dataArray2 count]))];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [menuButton2TableView reloadData];
                });
            }
            [UIView commitAnimations];
        }
        
        else if (menuButton2TableViewOpen == YES) {
            menuButton2TableViewOpen = NO;
            [menuButton2TableView setFrame:CGRectMake(menuButton2TableView.frame.origin.x, menuButton2TableViewYValue, menuButton2TableView.frame.size.width, menuButton2TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [menuButton2TableView setFrame:CGRectMake(menuButton2TableView.frame.origin.x, menuButton2TableView.frame.origin.y , menuButton2TableView.frame.size.width, 0)];
            menuButton2TableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
    
    if (sender.tag == 3) {
        if (menuButton3TableViewOpen == NO) {
            [self.view bringSubviewToFront:menuButton3TableView];
            menuButton3TableViewOpen = YES;
            menuButton3TableView.hidden = NO;
            [menuButton3TableView setFrame:CGRectMake(menuButton3TableView.frame.origin.x, menuButton3TableViewYValue + 1, menuButton3TableView.frame.size.width, menuButton3TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            if ([dataArray4 count] >= 10) {
                [menuButton3TableView setFrame:CGRectMake(menuButton3TableView.frame.origin.x, menuButton3TableView.frame.origin.y, menuButton3TableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [menuButton3TableView reloadData];
                });
            } else {
                [menuButton3TableView setFrame:CGRectMake(menuButton3TableView.frame.origin.x, menuButton3TableView.frame.origin.y, menuButton3TableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [dataArray4 count]))];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [menuButton3TableView reloadData];
                });
            }
            [UIView commitAnimations];
        }
        
        else if (menuButton3TableViewOpen == YES) {
            menuButton3TableViewOpen = NO;
            [menuButton3TableView setFrame:CGRectMake(menuButton3TableView.frame.origin.x, menuButton3TableViewYValue, menuButton3TableView.frame.size.width, menuButton3TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [menuButton3TableView setFrame:CGRectMake(menuButton3TableView.frame.origin.x, menuButton3TableView.frame.origin.y , menuButton3TableView.frame.size.width, 0)];
            menuButton3TableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
    if (sender.tag == 4) {
        if (whereMenuButtonTableViewOpen == NO) {
            [self.view bringSubviewToFront:whereMenuButtonTableView];
            whereMenuButtonTableViewOpen = YES;
            whereMenuButtonTableView.hidden = NO;
            [whereMenuButtonTableView setFrame:CGRectMake(whereMenuButtonTableView.frame.origin.x, whereMenuButtonTableViewYValue + 1, whereMenuButtonTableView.frame.size.width, whereMenuButtonTableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            if ([whereSectionDataArray count] >= 10) {
                [whereMenuButtonTableView setFrame:CGRectMake(whereMenuButtonTableView.frame.origin.x, whereMenuButtonTableView.frame.origin.y, whereMenuButtonTableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whereMenuButtonTableView reloadData];
                });
            } else {
                [whereMenuButtonTableView setFrame:CGRectMake(whereMenuButtonTableView.frame.origin.x, whereMenuButtonTableView.frame.origin.y, whereMenuButtonTableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [whereSectionDataArray count]))];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whereMenuButtonTableView reloadData];
                });
            }
            [UIView commitAnimations];
        }
        
        else if (whereMenuButtonTableViewOpen == YES) {
            whereMenuButtonTableViewOpen = NO;
            [whereMenuButtonTableView setFrame:CGRectMake(whereMenuButtonTableView.frame.origin.x, whereMenuButtonTableViewYValue, whereMenuButtonTableView.frame.size.width, whereMenuButtonTableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [whereMenuButtonTableView setFrame:CGRectMake(whereMenuButtonTableView.frame.origin.x, whereMenuButtonTableView.frame.origin.y , whereMenuButtonTableView.frame.size.width, 0)];
            whereMenuButtonTableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
    if (sender.tag == 5) {
        if (whenMenuButton1TableViewOpen == NO) {
            [self.view bringSubviewToFront:whenMenuButton1TableView];
            whenMenuButton1TableViewOpen = YES;
            whenMenuButton1TableView.hidden = NO;
            [whenMenuButton1TableView setFrame:CGRectMake(whenMenuButton1TableView.frame.origin.x, whenMenuButton1TableViewYValue + 1, whenMenuButton1TableView.frame.size.width, whenMenuButton1TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            if ([whenDataArray1 count] >= 10) {
                [whenMenuButton1TableView setFrame:CGRectMake(whenMenuButton1TableView.frame.origin.x, whenMenuButton1TableView.frame.origin.y, whenMenuButton1TableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whenMenuButton1TableView reloadData];
                });
            } else {
                [whenMenuButton1TableView setFrame:CGRectMake(whenMenuButton1TableView.frame.origin.x, whenMenuButton1TableView.frame.origin.y, whenMenuButton1TableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [whenDataArray1 count]))];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whenMenuButton1TableView reloadData];
                });
            }
            [UIView commitAnimations];
        }
        
        else if (whenMenuButton1TableViewOpen == YES) {
            whenMenuButton1TableViewOpen = NO;
            [whenMenuButton1TableView setFrame:CGRectMake(whenMenuButton1TableView.frame.origin.x, whenMenuButton1TableViewYValue, whenMenuButton1TableView.frame.size.width, whenMenuButton1TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [whenMenuButton1TableView setFrame:CGRectMake(whenMenuButton1TableView.frame.origin.x, whenMenuButton1TableView.frame.origin.y , whenMenuButton1TableView.frame.size.width, 0)];
            whenMenuButton1TableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
    if (sender.tag == 6) {
        if (whenMenuButton2TableViewOpen == NO) {
            [self.view bringSubviewToFront:whenMenuButton2TableView];
            whenMenuButton2TableViewOpen = YES;
            whenMenuButton2TableView.hidden = NO;
            [whenMenuButton2TableView setFrame:CGRectMake(whenMenuButton2TableView.frame.origin.x, whenMenuButton2TableViewYValue + 1, whenMenuButton2TableView.frame.size.width, whenMenuButton2TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            if ([whenDataArray2 count] >= 10) {
                [whenMenuButton2TableView setFrame:CGRectMake(whenMenuButton2TableView.frame.origin.x, whenMenuButton2TableView.frame.origin.y, whenMenuButton2TableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whenMenuButton2TableView reloadData];
                });
            } else {
                [whenMenuButton2TableView setFrame:CGRectMake(whenMenuButton2TableView.frame.origin.x, whenMenuButton2TableView.frame.origin.y, whenMenuButton2TableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [whenDataArray2 count]))];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whenMenuButton2TableView reloadData];
                });
            }
            [UIView commitAnimations];
        }
        
        else if (whenMenuButton2TableViewOpen == YES) {
            whenMenuButton2TableViewOpen = NO;
            [whenMenuButton2TableView setFrame:CGRectMake(whenMenuButton2TableView.frame.origin.x, whenMenuButton2TableViewYValue, whenMenuButton2TableView.frame.size.width, whenMenuButton2TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [whenMenuButton2TableView setFrame:CGRectMake(whenMenuButton2TableView.frame.origin.x, whenMenuButton2TableView.frame.origin.y , whenMenuButton2TableView.frame.size.width, 0)];
            whenMenuButton2TableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
    if (sender.tag == 7) {
        if (whenMenuButton3TableViewOpen == NO) {
            [self.view bringSubviewToFront:whenMenuButton3TableView];
            whenMenuButton3TableViewOpen = YES;
            whenMenuButton3TableView.hidden = NO;
            [whenMenuButton3TableView setFrame:CGRectMake(whenMenuButton3TableView.frame.origin.x, whenMenuButton3TableViewYValue + 1, whenMenuButton3TableView.frame.size.width, whenMenuButton3TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            if ([whenDataArray3 count] >= 10) {
                [whenMenuButton3TableView setFrame:CGRectMake(whenMenuButton3TableView.frame.origin.x, whenMenuButton3TableView.frame.origin.y, whenMenuButton3TableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whenMenuButton3TableView reloadData];
                });
            } else {
                [whenMenuButton3TableView setFrame:CGRectMake(whenMenuButton3TableView.frame.origin.x, whenMenuButton3TableView.frame.origin.y, whenMenuButton3TableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [whenDataArray3 count]))];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whenMenuButton3TableView reloadData];
                });
            }
            [UIView commitAnimations];
        }
        
        else if (whenMenuButton3TableViewOpen == YES) {
            whenMenuButton3TableViewOpen = NO;
            [whenMenuButton3TableView setFrame:CGRectMake(whenMenuButton3TableView.frame.origin.x, whenMenuButton3TableViewYValue, whenMenuButton3TableView.frame.size.width, whenMenuButton3TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [whenMenuButton3TableView setFrame:CGRectMake(whenMenuButton3TableView.frame.origin.x, whenMenuButton3TableView.frame.origin.y , whenMenuButton3TableView.frame.size.width, 0)];
            whenMenuButton3TableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
    if (sender.tag == 8) {
        if (whenMenuButton4TableViewOpen == NO) {
            [self.view bringSubviewToFront:whenMenuButton4TableView];
            whenMenuButton4TableViewOpen = YES;
            whenMenuButton4TableView.hidden = NO;
            [whenMenuButton4TableView setFrame:CGRectMake(whenMenuButton4TableView.frame.origin.x, whenMenuButton4TableViewYValue + 1, whenMenuButton4TableView.frame.size.width, whenMenuButton4TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            if ([whenDataArray4 count] >= 10) {
                [whenMenuButton4TableView setFrame:CGRectMake(whenMenuButton4TableView.frame.origin.x, whenMenuButton4TableView.frame.origin.y, whenMenuButton4TableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whenMenuButton4TableView reloadData];
                });
            } else {
                [whenMenuButton4TableView setFrame:CGRectMake(whenMenuButton4TableView.frame.origin.x, whenMenuButton4TableView.frame.origin.y, whenMenuButton4TableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [whenDataArray4 count]))];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [whenMenuButton4TableView reloadData];
                });
            }
            [UIView commitAnimations];
        }
        
        else if (whenMenuButton4TableViewOpen == YES) {
            whenMenuButton4TableViewOpen = NO;
            [whenMenuButton4TableView setFrame:CGRectMake(whenMenuButton4TableView.frame.origin.x, whenMenuButton4TableViewYValue, whenMenuButton4TableView.frame.size.width, whenMenuButton4TableView.frame.size.height)];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
            [whenMenuButton4TableView setFrame:CGRectMake(whenMenuButton4TableView.frame.origin.x, whenMenuButton4TableView.frame.origin.y , whenMenuButton4TableView.frame.size.width, 0)];
            whenMenuButton4TableView.hidden = YES;
            [UIView commitAnimations];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == autoCompleteTableView) {
        return [autoCompleteArray count];
    } else if (tableView == menuButton2TableView) {
        return [dataArray2 count];
    } else if (tableView == menuButton3TableView) {
        return [dataArray4 count];
    } else if (tableView == whereMenuButtonTableView) {
        return [whereSectionDataArray count];
    } else if (tableView == whenMenuButton1TableView) {
        return [whenDataArray1 count];
    } else if (tableView == whenMenuButton2TableView) {
        return [whenDataArray2 count];
    } else if (tableView == whenMenuButton3TableView) {
        return [whenDataArray3 count];
    } else if (tableView == whenMenuButton4TableView) {
        return [whenDataArray4 count];
    } else if (tableView == whereAutoCompleteTableView) {
        return [placesAutocompleteArray count];
    }
    
    return [dataArray1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == autoCompleteTableView) {
        NSString *cellIdentifier = @"AutoCompleteCell";
        AutoCompleteTableViewCell *cell = (AutoCompleteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = autoCompleteArray[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor redColor]];
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == menuButton2TableView) {
        NSString *cellIdentifier = @"MenuButton2Cell";
        MenuButton2TableViewCell *cell = (MenuButton2TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = dataArray2[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor redColor]];
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == menuButton3TableView) {
        NSString *cellIdentifier = @"MenuButton3Cell";
        MenuButton3TableViewCell *cell = (MenuButton3TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = dataArray4[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor redColor]];
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == whereMenuButtonTableView) {
        NSString *cellIdentifier = @"WhereMenuButton3Cell";
        WhereMenuButtonTableViewCell *cell = (WhereMenuButtonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = whereSectionDataArray[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor blueColor]];
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == whereAutoCompleteTableView) {
        NSString *cellIdentifier = @"WhereAutoCompleteCell";
        WhereAutoCompleteTableViewCell *cell = (WhereAutoCompleteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = placesAutocompleteArray[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor blueColor]];
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == whenMenuButton1TableView) {
        NSString *cellIdentifier = @"WhenMenuButton1Cell";
        WhenMenuButton1TableViewCell *cell = (WhenMenuButton1TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = whenDataArray1[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor purpleColor]];
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == whenMenuButton2TableView) {
        NSString *cellIdentifier = @"WhenMenuButton2Cell";
        WhenMenuButton2TableViewCell *cell = (WhenMenuButton2TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = whenDataArray2[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor purpleColor]];
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == whenMenuButton3TableView) {
        NSString *cellIdentifier = @"WhenMenuButton3Cell";
        WhenMenuButton3TableViewCell *cell = (WhenMenuButton3TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = whenDataArray3[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor purpleColor]];
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    if (tableView == whenMenuButton4TableView) {
        NSString *cellIdentifier = @"WhenMenuButton4Cell";
        WhenMenuButton4TableViewCell *cell = (WhenMenuButton4TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
        cell.cellLabel.text = whenDataArray4[indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
        [cell.cellLabel setBackgroundColor:[UIColor purpleColor]];
        
        CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
        
        cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
        
        return cell;
    }
    
    // Code for ActivityListTableView
    NSString *cellIdentifier = @"ActivityListCell";
    MenuButton1TableViewCell *cell = (MenuButton1TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.cellLabel.font = [UIFont fontWithName:@"Karla-Bold" size:18];
    cell.cellLabel.text = dataArray1[indexPath.row];
    cell.cellLabel.textColor = [UIColor whiteColor];
    [cell.cellLabel setBackgroundColor:[UIColor redColor]];
    
    CGFloat width =  ceil([cell.cellLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
    
    cell.cellLabel.frame = CGRectMake(cell.cellLabel.frame.origin.x, cell.cellLabel.frame.origin.y, width, cell.cellLabel.frame.size.height);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return TABLEVIEWCELL_ROW_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == autoCompleteTableView) {
        [fieldTextField1 setText:autoCompleteArray[indexPath.row]];
        autoCompleteTableView.hidden = YES;
    }
    
    if (tableView == menuButton2TableView) {
        [menuButton2 setTitle:dataArray2[indexPath.row] forState:UIControlStateNormal];
        [self performSelector:@selector(showHideDropdown:) withObject:menuButton2TableView afterDelay:0];
    }
    
    if (tableView == menuButton3TableView) {
        [menuButton3 setTitle:dataArray4[indexPath.row] forState:UIControlStateNormal];
        [self performSelector:@selector(showHideDropdown:) withObject:menuButton3TableView afterDelay:0];
    }

    if (tableView == menuButton1TableView) {
        [menuButton1 setTitle:dataArray1[indexPath.row] forState:UIControlStateNormal];
        
        MenuButton1TableViewCell *cell = (MenuButton1TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        CGRect rect = cell.cellLabel.frame;
        rect.origin.x += 10;
        [MenuButton1TableViewCell animateWithDuration:0.1 animations:^{
            cell.cellLabel.frame = rect;
        } completion:^(BOOL finished) {
            if (finished) {
                CGRect rect2 = cell.cellLabel.frame;
                rect2.origin.x -= 9;
                [MenuButton1TableViewCell animateWithDuration:0.1 animations:^{
                    cell.cellLabel.frame = rect2;
                } completion:^(BOOL finished) {
                    if (finished) {
                        CGRect rect3 = cell.cellLabel.frame;
                        rect3.origin.x -= 1;
                        [MenuButton1TableViewCell animateWithDuration:0.1 animations:^{
                            cell.cellLabel.frame = rect3;
                        } completion:^(BOOL finished) {
                            if (finished) {
                                [self performSelector:@selector(showHideDropdown:) withObject:menuButton1TableView afterDelay:0];
                                whatMenuButton1Selection = (int)indexPath.row;
                                [self shiftWhatElements:[self determineWhatUIElementLayout:indexPath.row]];
                            }
                        }];
                    }
                }];
            }
        }];
    }
    
    if (tableView == whereMenuButtonTableView) {
        [whereMenuButton setTitle:whereSectionDataArray[indexPath.row] forState:UIControlStateNormal];
        
        WhereMenuButtonTableViewCell *cell = (WhereMenuButtonTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        CGRect rect = cell.cellLabel.frame;
        rect.origin.x += 10;
        [WhereMenuButtonTableViewCell animateWithDuration:0.1 animations:^{
            cell.cellLabel.frame = rect;
        } completion:^(BOOL finished) {
            if (finished) {
                CGRect rect2 = cell.cellLabel.frame;
                rect2.origin.x -= 9;
                [WhereMenuButtonTableViewCell animateWithDuration:0.1 animations:^{
                    cell.cellLabel.frame = rect2;
                } completion:^(BOOL finished) {
                    if (finished) {
                        CGRect rect3 = cell.cellLabel.frame;
                        rect3.origin.x -= 1;
                        [WhereMenuButtonTableViewCell animateWithDuration:0.1 animations:^{
                            cell.cellLabel.frame = rect3;
                        } completion:^(BOOL finished) {
                            if (finished) {
                                [self performSelector:@selector(showHideDropdown:) withObject:whereMenuButtonTableView afterDelay:0];
                                [self shiftWhereElements:[self determineWhereUIElementLayout:indexPath.row]];
                            }
                        }];
                    }
                }];
            }
        }];
    }
    
    if (tableView == whereAutoCompleteTableView) {
        //Change AutoComplete Array Variable Name
        [whereFieldText setText:placesAutocompleteArray[indexPath.row]];
        whereAutoCompleteTableView.hidden = YES;
    }
    
    if (tableView == whenMenuButton1TableView) {
        [whenMenuButton1 setTitle:whenDataArray1[indexPath.row] forState:UIControlStateNormal];
        
        WhenMenuButton1TableViewCell *cell = (WhenMenuButton1TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        CGRect rect = cell.cellLabel.frame;
        rect.origin.x += 10;
        [WhenMenuButton1TableViewCell animateWithDuration:0.1 animations:^{
            cell.cellLabel.frame = rect;
        } completion:^(BOOL finished) {
            if (finished) {
                CGRect rect2 = cell.cellLabel.frame;
                rect2.origin.x -= 9;
                [WhenMenuButton1TableViewCell animateWithDuration:0.1 animations:^{
                    cell.cellLabel.frame = rect2;
                } completion:^(BOOL finished) {
                    if (finished) {
                        CGRect rect3 = cell.cellLabel.frame;
                        rect3.origin.x -= 1;
                        [WhenMenuButton1TableViewCell animateWithDuration:0.1 animations:^{
                            cell.cellLabel.frame = rect3;
                        } completion:^(BOOL finished) {
                            if (finished) {
                                [self performSelector:@selector(showHideDropdown:) withObject:whenMenuButton1TableView afterDelay:0];
                            }
                        }];
                    }
                }];
            }
        }];
    }
    if (tableView == whenMenuButton2TableView) {
        [whenMenuButton2 setTitle:whenDataArray2[indexPath.row] forState:UIControlStateNormal];
        
        WhenMenuButton2TableViewCell *cell = (WhenMenuButton2TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        CGRect rect = cell.cellLabel.frame;
        rect.origin.x += 10;
        [WhenMenuButton2TableViewCell animateWithDuration:0.1 animations:^{
            cell.cellLabel.frame = rect;
        } completion:^(BOOL finished) {
            if (finished) {
                CGRect rect2 = cell.cellLabel.frame;
                rect2.origin.x -= 9;
                [WhenMenuButton2TableViewCell animateWithDuration:0.1 animations:^{
                    cell.cellLabel.frame = rect2;
                } completion:^(BOOL finished) {
                    if (finished) {
                        CGRect rect3 = cell.cellLabel.frame;
                        rect3.origin.x -= 1;
                        [WhenMenuButton2TableViewCell animateWithDuration:0.1 animations:^{
                            cell.cellLabel.frame = rect3;
                        } completion:^(BOOL finished) {
                            if (finished) {
                                [self performSelector:@selector(showHideDropdown:) withObject:whenMenuButton2TableView afterDelay:0];
                                if (indexPath.row == 0 || indexPath.row == 1) {
                                    [self shiftWhenElements:FALSE];
                                } else {
                                    [self shiftWhenElements:TRUE];
                                }
                            }
                        }];
                    }
                }];
            }
        }];
    }
    if (tableView == whenMenuButton3TableView) {
        [whenMenuButton3 setTitle:whenDataArray3[indexPath.row] forState:UIControlStateNormal];
        
        WhenMenuButton3TableViewCell *cell = (WhenMenuButton3TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        CGRect rect = cell.cellLabel.frame;
        rect.origin.x += 10;
        [WhenMenuButton3TableViewCell animateWithDuration:0.1 animations:^{
            cell.cellLabel.frame = rect;
        } completion:^(BOOL finished) {
            if (finished) {
                CGRect rect2 = cell.cellLabel.frame;
                rect2.origin.x -= 9;
                [WhenMenuButton3TableViewCell animateWithDuration:0.1 animations:^{
                    cell.cellLabel.frame = rect2;
                } completion:^(BOOL finished) {
                    if (finished) {
                        CGRect rect3 = cell.cellLabel.frame;
                        rect3.origin.x -= 1;
                        [WhenMenuButton3TableViewCell animateWithDuration:0.1 animations:^{
                            cell.cellLabel.frame = rect3;
                        } completion:^(BOOL finished) {
                            if (finished) {
                                [self performSelector:@selector(showHideDropdown:) withObject:whenMenuButton3TableView afterDelay:0];
                            }
                        }];
                    }
                }];
            }
        }];
    }
    if (tableView == whenMenuButton4TableView) {
        [whenMenuButton4 setTitle:whenDataArray4[indexPath.row] forState:UIControlStateNormal];
        
        WhenMenuButton4TableViewCell *cell = (WhenMenuButton4TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        CGRect rect = cell.cellLabel.frame;
        rect.origin.x += 10;
        [WhenMenuButton4TableViewCell animateWithDuration:0.1 animations:^{
            cell.cellLabel.frame = rect;
        } completion:^(BOOL finished) {
            if (finished) {
                CGRect rect2 = cell.cellLabel.frame;
                rect2.origin.x -= 9;
                [WhenMenuButton4TableViewCell animateWithDuration:0.1 animations:^{
                    cell.cellLabel.frame = rect2;
                } completion:^(BOOL finished) {
                    if (finished) {
                        CGRect rect3 = cell.cellLabel.frame;
                        rect3.origin.x -= 1;
                        [WhenMenuButton4TableViewCell animateWithDuration:0.1 animations:^{
                            cell.cellLabel.frame = rect3;
                        } completion:^(BOOL finished) {
                            if (finished) {
                                [self performSelector:@selector(showHideDropdown:) withObject:whenMenuButton4TableView afterDelay:0];
                            }
                        }];
                    }
                }];
            }
        }];
    }
}

-(void) textFieldDidChange:(UITextField *)senderTextField {
    if (senderTextField.tag == 0) {
        if ([senderTextField.text isEqualToString:@""]) {
            autoCompleteTableView.hidden = YES;
        } else {
            autoCompleteTableView.hidden = NO;
        }
        
        [self searchAutocompleteEntriesWithSubstringInTextField:senderTextField];
    }
    
    if (senderTextField.tag == 1) {
        if ([senderTextField.text isEqualToString:@""]) {
            senderTextField.frame = CGRectMake(senderTextField.frame.origin.x, senderTextField.frame.origin.y, 175, senderTextField.frame.size.height);
            if ([fieldTextField2 respondsToSelector:@selector(setAttributedPlaceholder:)]) {
                UIColor *color = [UIColor whiteColor];
                fieldTextField2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:fieldTextField2Placeholder attributes:@{NSForegroundColorAttributeName: color}];
            } else {
                NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            }
        } else {
            CGFloat width =  ceil([senderTextField.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Karla-Bold" size:18.0]}].width);
            
            senderTextField.frame = CGRectMake(senderTextField.frame.origin.x, senderTextField.frame.origin.y, width + 5, senderTextField.frame.size.height);
        }
    }
    
    if (senderTextField.tag == 2) {
        if ([senderTextField.text isEqualToString:@""]) {
            if ([whereFieldText respondsToSelector:@selector(setAttributedPlaceholder:)]) {
                UIColor *color = [UIColor whiteColor];
                whereFieldText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:whereFieldTextPlaceholder attributes:@{NSForegroundColorAttributeName: color}];
            } else {
                NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            }
        }
        
        if ([senderTextField.text isEqualToString:@""]) {
            whereAutoCompleteTableView.hidden = YES;
        } else {
            whereAutoCompleteTableView.hidden = NO;
        }
        

        [self searchGooglePlacesAutocompleteEntriesWithSubstringInTextField:senderTextField];
    }
}

- (void)searchAutocompleteEntriesWithSubstringInTextField:(UITextField *)senderTextField {
    
    // Put anything that contains this substring into the autoCompleteArray
    // The items in this array is what will show up in the table view
    
    [autoCompleteArray removeAllObjects];
    
    for(NSString *nameString in [self allSports_L2]) {
        NSRange substringRange = [nameString rangeOfString:senderTextField.text];
        if (substringRange.location != NSNotFound) {
            [autoCompleteArray addObject:nameString];
        }
    }
    
    [self.view bringSubviewToFront:autoCompleteTableView];
    
    if ([autoCompleteArray count] >= 10) {
        [autoCompleteTableView setFrame:CGRectMake(autoCompleteTableView.frame.origin.x, autoCompleteTableView.frame.origin.y, autoCompleteTableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [autoCompleteTableView reloadData];
        });
    } else {
        [autoCompleteTableView setFrame:CGRectMake(autoCompleteTableView.frame.origin.x, autoCompleteTableView.frame.origin.y, autoCompleteTableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [autoCompleteArray count]))];
        dispatch_async(dispatch_get_main_queue(), ^{
            [autoCompleteTableView reloadData];
        });
    }
}

-(void) searchGooglePlacesAutocompleteEntriesWithSubstringInTextField:(UITextField *)senderTextField {
    [placesAutocompleteArray removeAllObjects];
    
    SPGooglePlacesAutocompleteQuery *query = [SPGooglePlacesAutocompleteQuery query];
    query.input = senderTextField.text;
    query.radius = 50000.0;
    query.language = @"en";
    query.types = placesQueryType;
    query.location = userLocation.coordinate;
    
    [query fetchPlaces:^(NSArray *places, NSError *error) {
        for (int i = 0; i < [places count]; i++) {
            SPGooglePlacesAutocompletePlace *place = places[i];
            [placesAutocompleteArray addObject:place.name];
        }
        
        placesArray = places;
        
        [self.view bringSubviewToFront:whereAutoCompleteTableView];
        
        if ([placesAutocompleteArray count] >= 10) {
            [whereAutoCompleteTableView setFrame:CGRectMake(whereAutoCompleteTableView.frame.origin.x, whereAutoCompleteTableView.frame.origin.y, whereAutoCompleteTableView.frame.size.width, TABLEVIEW_MAX_HEIGHT)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [whereAutoCompleteTableView reloadData];
            });
        } else {
            [whereAutoCompleteTableView setFrame:CGRectMake(whereAutoCompleteTableView.frame.origin.x, whereAutoCompleteTableView.frame.origin.y, whereAutoCompleteTableView.frame.size.width, (TABLEVIEWCELL_ROW_HEIGHT * [placesAutocompleteArray count]))];
            dispatch_async(dispatch_get_main_queue(), ^{
                [whereAutoCompleteTableView reloadData];
            });
        }
    }];
}

-(void) retractAllDropDowns {
    autoCompleteTableView.hidden = YES;
    
    menuButton2TableViewOpen = YES;
    [self performSelector:@selector(showHideDropdown:) withObject:menuButton2TableView afterDelay:0];
    
    menuButton3TableViewOpen = YES;
    [self performSelector:@selector(showHideDropdown:) withObject:menuButton3TableView afterDelay:0];
}

- (IBAction)menuButton1Pressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)menuButton2Pressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)menuButton3Pressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)whereButtonPressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)whenMenuButton1Pressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)whenMenuButton2Pressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)whenMenuButton3Pressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)whenMenuButton4Pressed:(id)sender {
    [self performSelector:@selector(showHideDropdown:) withObject:sender afterDelay:0];
}

- (IBAction)createButtonPressed:(id)sender {
}

@end