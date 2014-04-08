
//
//  listenerScreenTouched.m
//  proj358
//
//  Created by Fabien Saint-Blancat on 03/04/2014.
//  Copyright (c) 2014 Fabien Saint-Blancat. All rights reserved.
//

#import "listenerScreenTouched.h"
#import <UIKit/UIKit.h>

@implementation listenerScreenTouched

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];

    NSString* coord = [NSString stringWithFormat:@"screen touched at x_%f y_%f\n",location.x, location.y];
    NSLog(@"coucuo");
    NSLog(@"%@", coord);
}



-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    NSString* coord = [NSString stringWithFormat:@"screen touched at x_%f y_%f\n",location.x, location.y];
    
    NSLog(@"%@", coord);
    
}


@end

