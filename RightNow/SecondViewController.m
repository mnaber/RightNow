//
//  SecondViewController.m
//  RightNow
//
//  Created by Michael Naber on 3/19/14.
//  Copyright (c) 2014 Team6Labs. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        // allowed
       
    } else {
        // not allowed
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Announcement" message: @"Please allow us to use your current location. We use this to tell the temperature of where you are. You can allow location tracking by going to Settings > Privacy > Location Services. Thanks & Enjoy!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
