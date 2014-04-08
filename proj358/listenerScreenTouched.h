//
//  listenerScreenTouched.h
//  proj358
//
//  Created by Fabien Saint-Blancat on 03/04/2014.
//  Copyright (c) 2014 Fabien Saint-Blancat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listenerScreenTouched : NSObject

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer;

@end
