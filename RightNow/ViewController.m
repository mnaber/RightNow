//
//  ViewController.m
//  RightNow
//
//  Created by Michael Naber on 3/16/14.
//  Copyright (c) 2014 Team6Labs. All rights reserved.
// http://weather.service.msn.com/find.aspx?outputview=search&weasearchstr={0}.
// http://local.msn.com/weather.aspx?zip=10038
// api.openweathermap.org/data/2.5/weather?q=London&mode=xml
// http://api.openweathermap.org/data/2.5/weather?q=Chicago&mode=html&units=imperial
//Chicago&mode=html&units=imperial
// api.openweathermap.org/data/2.5/weather?lat=35&lon=139&mode=html

/*
    UPDATE Reminders - Check to make sure maps is not constantly updating. Also make refresh easier.
 
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize responseData;
@synthesize queryURL;

- (void)viewDidLoad
{   [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
 //   NSLog(@"Latitude: %f", locationManager.location.coordinate.latitude);
 //   NSLog(@"Longitude: %f", locationManager.location.coordinate.longitude);

    [self refreshData];
    
    [self getFeed];
    [self getWeather];
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Announcement" message: @"Thanks & Enjoy!" delegate: self cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getFeed {
    NSURL *url = [NSURL URLWithString:@"http://rss.cnn.com/rss/cnn_topstories.rss"];
   // NSXMLParser *feedParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
   // NSString *feedString = [NSString stringWithFormat:@"%@", feedParser];'
    NSError *error;
    NSString *feedString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
 //   NSLog(@"FeedString: %@", feedString);
    
    NSArray *stringComponents = [feedString componentsSeparatedByString:@":"];
    NSString *desiredComponents = [stringComponents objectAtIndex:25];
  //  NSLog(@"Feed Title: %@", desiredComponents);
    NSArray *secondComponentArray =  [desiredComponents componentsSeparatedByString:@"</title>"];
 //   NSLog(@"Feed Title2: %@", secondComponentArray);
    NSString *finalComponentString = [secondComponentArray objectAtIndex:0];
 //   NSLog(@"FinalTitle3: %@", finalComponentString);
    //_headlinesLabel.text = [NSString stringWithFormat:@"Headlines: %@",finalComponentString];
    /*
    NSURL *expoUrl = [NSURL URLWithString:@"http://rss.newser.com/rss/section/1.rss"];
    NSError *expoError;
    NSString *expoFeedString = [NSString stringWithContentsOfURL:expoUrl encoding:NSASCIIStringEncoding error:&expoError];
//    NSLog(@"FeedString: %@", expoFeedString);
    NSArray *expoStringComponents = [expoFeedString componentsSeparatedByString:@"<title>"];
    NSString *expoDesiredComponents = [expoStringComponents objectAtIndex:3];
 //   NSLog(@"expoDesiredComponents: %@", expoStringComponents);

    NSArray *expoSecondStringComponents = [expoDesiredComponents componentsSeparatedByString:@"</title>"];
    NSString *expoSecondDesiredComponents = [expoSecondStringComponents objectAtIndex:0];
    NSLog(@"Head Lines: %@", expoSecondDesiredComponents);
    _headlinesLabel.text = [NSString stringWithFormat:@"Headlines: %@",expoSecondDesiredComponents];
     */
    NSURL *expoUrl = [NSURL URLWithString:@"http://rss.cnn.com/rss/cnn_topstories.rss"];
    NSError *expoError;
    NSString *expoFeedString = [NSString stringWithContentsOfURL:expoUrl encoding:NSASCIIStringEncoding error:&expoError];
  //      NSLog(@"FeedString: %@", expoFeedString);
    NSArray *expoStringComponents = [expoFeedString componentsSeparatedByString:@"<title>"];
    NSString *expoDesiredComponents = [expoStringComponents objectAtIndex:3];
    //   NSLog(@"expoDesiredComponents: %@", expoStringComponents);
    
    NSArray *expoSecondStringComponents = [expoDesiredComponents componentsSeparatedByString:@"</title>"];
    NSString *expoSecondDesiredComponents = [expoSecondStringComponents objectAtIndex:0];
//    NSLog(@"Head Lines: %@", expoSecondDesiredComponents);
    _headlinesLabel.text = [NSString stringWithFormat:@"Headlines: %@",expoSecondDesiredComponents];
}



-(void) getWeather {
    // Experimental Weather Data Gathering
    NSString *latitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
    NSString *expoRequest = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&mode=csv&units=imperial", latitude,longitude];
 //   NSLog(@"ExpoRequest URL: %@", expoRequest);
    NSURL *expoURL = [NSURL URLWithString:expoRequest];
    NSError *expoError;
    NSString *expoXML = [NSString stringWithContentsOfURL:expoURL encoding:NSASCIIStringEncoding error:&expoError];
  //  NSLog(@"%@", expoXML);
    NSArray *expoStringComponents = [expoXML componentsSeparatedByString:@":"];
    NSString *expoDesiredComponent = [expoStringComponents objectAtIndex:16];
  //  NSLog(@"ExpoDesiredComponent", expoDesiredComponent);
    // Expo Gets Temperature
    NSString *expoTemperature = [expoDesiredComponent substringWithRange:NSMakeRange(0, 5)];
 //  NSLog(@"EXPO Temperature: %@",expoTemperature);
    _degreeString.text = [NSString stringWithFormat:@"%@°F", expoTemperature];
    /*
    
    // Functional Weather Data Gathering
    NSString * location =  @"chicago";
    NSString * address = @"http://api.openweathermap.org/data/2.5/weather?q=";
    NSString * request = [NSString stringWithFormat:@"%@%@&mode=xml&units=imperial",address,location];
    NSURL * URL = [NSURL URLWithString:request];
    NSError * error;
    NSString* XML = [NSString stringWithContentsOfURL:URL encoding:NSASCIIStringEncoding error:&error];
    NSLog(@"%@", XML);
    _degreeString.text = [NSString stringWithFormat:@"Temperature: %@", expoTemperature];
    
    
    NSArray *stringComponents = [XML componentsSeparatedByString:@"="];
    NSString *desiredComponent = [stringComponents objectAtIndex:6];
    NSLog(@"%@", desiredComponent);
    // Gets temperature
    NSString *temperature = [desiredComponent substringWithRange:NSMakeRange(1, 5)];
    NSLog(@"%@", temperature);
 //   _degreeString.text = [NSString stringWithFormat:@"Temperature: %@", temperature];
    
    // Extract current temperature the 'dirty' way
  //  NSArray * temp = [[[[XML componentsSeparatedByString:@"temperature data"] objectAtIndex:1] componentsSeparatedByString:@"\""] objectAtIndex:0];
   // NSLog(@"It's currently %@ degree in %@.", temp, location);
    
    
    //Parse the XML with NSXMLDocument to extract the data properly
   // NSXMLDocument *doc = [[NSXMLDocument alloc] initWithXMLString:XML options:0 error:NULL];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    NSLog(@"%@",parser);
     
     if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
     // allowed
     
     } else {
     // not allowed
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Announcement" message: @"Please allow us to use your current location. We use this to tell the temperature of where you are. You can allow location tracking by going to Settings > Privacy > Location Services. Thanks & Enjoy!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
     
     }

     */
}


-(void) refreshData {
   // NSDate *now = [NSDate date];
   
    
    NSDate *now = [NSDate date];
	NSDateFormatter *formatter = nil;
	formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
//	[timeLabel setText:[formatter stringFromDate:now]];
   //_dateLabel.text = [NSString stringWithFormat:@"%@", now];
    
    // Sets Time
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    _dateLabel.text = resultString;
    
    // Sets S&P 500 Change
    
    NSError *error;
    NSString *rawStockQuote = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://download.finance.yahoo.com/d/quotes.csv?s=SPY&f=sl1d1t1c1ohgv&e=.csv"] encoding:NSASCIIStringEncoding error:&error];
  //  NSLog(@"%@", rawStockQuote);
    NSArray *stringComponents = [rawStockQuote componentsSeparatedByString:@","];
    NSString *desiredComponent = [stringComponents objectAtIndex:4];
    NSString *totalPrice = [stringComponents objectAtIndex:5];
    float desiredComponentNumber = [desiredComponent floatValue];
    float totalPriceNumber = [totalPrice floatValue];
    float finalPrice = desiredComponentNumber/totalPriceNumber;
 //   NSLog(@"Final Percentage Change: %f", finalPrice);
 //   NSLog(@"%@", desiredComponent);
    float percentageChangeExpo = finalPrice/totalPriceNumber;
    
    
   // [altitude setText:[NSString stringWithFormat:@"%.2f", alt]];
    [_stockLabel setText:[NSString stringWithFormat:@"S&P 500", finalPrice]];
    
    // Sets image for up or down arrow for stocks
    
    float stringFloat = [desiredComponent floatValue];
    
    if(stringFloat>0){
        self.stockImage = [UIImage imageNamed:@"upgreenbutton.png"];
    }
    else if(stringFloat<0){
        self.stockImage = [UIImage imageNamed:@"downredbutton.png"];
    }
    [_upStockImage setImage:_stockImage];
}

-(NSString *) deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
  //  NSLog(@"%@",[NSString stringWithFormat:@"latitude: %f longitude: %@", locationManager.location.coordinate.latitude, locationManager]);
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //u need to change 0 to other value(,1,2,3) if u have more buttons.then u can check which button was pressed.
    
    if (buttonIndex == 0) {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
            // allowed
            [self getWeather];
            [self getFeed];
            [self refreshData];
        } else {
            // not allowed
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Announcement" message: @"Please allow us to use your current location. We use this to tell the temperature of where you are. You can allow location tracking by going to Settings > Privacy > Location Services. Thanks & Enjoy!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
            
        }
        
    }}

- (IBAction)refreshButton3:(id)sender {
 //   NSLog(@"Method refreshButton2 Called");
        [self refreshData];
 //   NSLog(@"Method refreshData called");
        [self getWeather];
//    NSLog(@"Method selfGetWeather Called");
        [self getFeed];
 //   NSLog(@"Method self getfeed called");
}
@end
