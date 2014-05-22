//
//  ViewController.h
//  RightNow
//
//  Created by Michael Naber on 3/16/14.
//  Copyright (c) 2014 Team6Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <NSURLConnectionDataDelegate,CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSString *queryURL;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upStockImage;
@property (weak, nonatomic) IBOutlet UILabel *headlinesLabel;
- (IBAction)refreshButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *degreeString;
@property (nonatomic, weak) UIImage *stockImage;

@end
