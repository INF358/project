//
//  ScreenRec.m
//  proj358
//
//  Created by Fabien Saint-Blancat on 07/04/2014.
//  Copyright (c) 2014 Fabien Saint-Blancat. All rights reserved.
//

#import "ScreenRec.h" 

void CARenderServerRenderDisplay(kern_return_t a, CFStringRef b, IOSurfaceRef surface, int x, int y);

@interface ScreenRec ()

@end


@implementation ScreenRec

-(IOSurfaceRef) createScreenSurface
{
    // Pixel format for Alpha Red Green Blue
    unsigned pixelFormat = 0x42475241;//'ARGB';
    
    // 4 Bytes per pixel
    int bytesPerElement = 4;
    
    // Bytes per row
    _bytesPerRow = (bytesPerElement * _width);
    
    // Properties include: SurfaceIsGlobal, BytesPerElement, BytesPerRow, SurfaceWidth, SurfaceHeight, PixelFormat, SurfaceAllocSize (space for the entire surface)
    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithBool:YES], kIOSurfaceIsGlobal,
                                [NSNumber numberWithInt:bytesPerElement], kIOSurfaceBytesPerElement,
                                [NSNumber numberWithInt:_bytesPerRow], kIOSurfaceBytesPerRow,
                                [NSNumber numberWithInt:_width], kIOSurfaceWidth,
                                [NSNumber numberWithInt:_height], kIOSurfaceHeight,
                                [NSNumber numberWithUnsignedInt:pixelFormat], kIOSurfacePixelFormat,
                                [NSNumber numberWithInt:_bytesPerRow * _height], kIOSurfaceAllocSize,
                                nil];
    
    // This is the current surface
    return IOSurfaceCreate((__bridge CFDictionaryRef)properties);
    
}

-(NSMutableData*) captureShot
{
    _surface = [self createScreenSurface];
    CARenderServerRenderDisplay(0, CFSTR("LCD"), _surface, 0, 0);
    
    // Make a raw memory copy of the surface
    void *baseAddr = IOSurfaceGetBaseAddress(_surface);
    int totalBytes = _bytesPerRow * _height;
    
    //void *rawData = malloc(totalBytes);
    //memcpy(rawData, baseAddr, totalBytes);
    NSMutableData * rawDataObj = nil;
    rawDataObj = [NSMutableData dataWithBytes:baseAddr length:totalBytes];
    
    return rawDataObj;
}



@end
