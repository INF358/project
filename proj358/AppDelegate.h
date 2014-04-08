//
//  AppDelegate.h
//  proj358
//
//  Created by Fabien Saint-Blancat on 19/03/2014.
//  Copyright (c) 2014 Fabien Saint-Blancat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenRec.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSArray *paths;
    NSString *filePath;
    NSString *fileName;
    NSString *coord;
    NSOutputStream *stream;
    NSData *data;
    NSSet* touches;
    UIEvent* event;
    
}
@property (strong, nonatomic) UIWindow *window;

-(NSString*) filePath;
-(void) setFilePath:(NSString*)newFilePath;
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) openFileStream:(NSString*) filePath;
-(void) initiateLog;
-(void) defineFilePath:(NSString*) deviceUDID;
- (BOOL)uploadImgFile:(NSString *) fileName withFilePath:(NSString*) filePath;

@end
