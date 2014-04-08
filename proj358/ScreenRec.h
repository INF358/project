//
//  ScreenRec.h
//  proj358
//
//  Created by Fabien Saint-Blancat on 07/04/2014.
//  Copyright (c) 2014 Fabien Saint-Blancat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOSurface.h"

@interface ScreenRec : NSObject

{
@private
    
    //surface
    IOSurfaceRef        _surface;
    int                 _bytesPerRow;
    int                 _width;
    int                 _height;
    
}
-(IOSurfaceRef) createScreenSurface;
-(NSMutableData*) captureShot;


@end
