//
//  ViewController.m
//  proj358
//
//  Created by Fabien Saint-Blancat on 19/03/2014.
//  Copyright (c) 2014 Fabien Saint-Blancat. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "listenerScreenTouched.h"
#import <QuartzCore/CALayer.h>


//First comment

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIWindow *keyTarget = [[UIApplication sharedApplication] keyWindow];
    NSInteger winNum = [keyTarget windowLevel];
    
    NSString* deviceUDID = [[UIDevice currentDevice] uniqueIdentifier];
    NSLog(@"%@", deviceUDID);
    
    NSLog(@"viewDidLoad : %d",winNum);
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd-MM-yyyy"];
    NSLog(@"l'heure : %@", [df stringFromDate:date]);
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}   


@end
