//
//  ViewController.h
//  proj358
//
//  Created by Fabien Saint-Blancat on 19/03/2014.
//  Copyright (c) 2014 Fabien Saint-Blancat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface ViewController : UIViewController
{
    float launchVolume;
    float currentVolume;

    NSSet* touches;
    UIEvent* event;
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)launchSettingsButton:(id)sender;

-(void) openFileStream:(NSString*) filePath;




@end
