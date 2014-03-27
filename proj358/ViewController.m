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

@interface ViewController ()

@end

//First comment

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"appli lancée");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Fonction pour récupérer les coordonnées de l'écran ayant été touchées
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    NSLog(@"screen touched at x_%f y_%f", location.x, location.y);
    
}


//Fonction lié à l'appui sur le bouton pour lancer les settings
- (IBAction)launchSettingsButton:(id)sender
{
    NSLog(@"settings button pressed");
    
}



@end
