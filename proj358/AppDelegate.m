//
//  AppDelegate.m
//  proj358
//
//  Created by Fabien Saint-Blancat on 19/03/2014.
//  Copyright (c) 2014 Fabien Saint-Blancat. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UIKit/UIKit.h>

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"appli lancée");
    
    //On lit le contenu du fichier au demarrage - uniquement pour la période de test
    //NSString* contenu = [self readFileContent:filePath];
    //NSLog(@"Le fichier vaut maintenant: %@\n", contenu);

    
    /*NSString *stringURL = @"http://www.google.fr";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
    
    exit(0);*/
    
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /*
    NSString* deviceUDID = [[UIDevice currentDevice] uniqueIdentifier];
    
    //on definit le path du fichier
    [self defineFilePath:deviceUDID];

    //on ouvre le flux d ecriture
    [self openFileStream: filePath];
   
    //on initialise les logs sur la session
    [self initiateLog];
     */
        
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:self];
    NSLog(@"Home button pressed or incoming phone call");
    NSLog(@"Transfert du fichier de log vers le serveur");
    
    
    /*
    //Envoi du fichier de log vers le serveur
    BOOL isFileSent = [self uploadDataFile: fileName withFilePath: filePath];
    NSLog(@"%c\n",isFileSent);
    //on verifie que le transfert a bien ete effectue et on clear les logs
    if (isFileSent == TRUE){
        [self clearFile:filePath];
    }
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //Ici rappeler la fonction de transfert vers l url du SMS pour ne pas lancer cette application en Foreground
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//////////////////////////
//Permet de définir le chemin et fichier a utiliser pour les logs
//////////////////////////

-(void) defineFilePath:(NSString*) deviceUDID
{
    //on definit un nom de fichier/chemin du fichier par l udid de l utilisateur
    fileName = [NSString stringWithFormat:@"%@.txt",deviceUDID];
    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    
    filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:fileName];
   [self setFilePath:filePath];

}


//////////////////////////
//Permet d'ouvrir un flux pour écrire dans le fichier <udid>.txt
//////////////////////////
-(void) openFileStream:(NSString*) filePath
{
    // Open output file in append mode:
    stream = [[NSOutputStream alloc] initToFileAtPath:[self filePath] append:YES];
    [stream open];
    
}

//////////////////////////
//Permet d initialiser les logs
//////////////////////////
-(void) initiateLog
{
    // on récupère l'heure et la date
    NSDate *date = [NSDate date];
    NSDateFormatter *miseEnForme = [[NSDateFormatter alloc] init];
    //NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    //[miseEnForme setLocale:frLocale];
    
    NSString* temp = [NSString stringWithFormat:@"Log du device %@ à : %@\n",[[UIDevice currentDevice] uniqueIdentifier], [miseEnForme stringFromDate:date]];
    data = [temp dataUsingEncoding:NSUTF8StringEncoding];
    [stream write:data.bytes maxLength:data.length];
}

/////////////////
//Permet de loger les coordonnées de l'écran pressées dans le fichier <udid>.txt
/////////////////
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    coord = [NSString stringWithFormat:@"screen touched at x_%f y_%f\n",location.x, location.y];
    data = [coord dataUsingEncoding:NSUTF8StringEncoding];
    // Write data to output file:
    [stream write:data.bytes maxLength:data.length];
    
    NSLog(@"%@", coord);
    
}

/////////////////
//Permet de lire le fichier <udid>.txt
/////////////////
-(NSString*)readFileContent:(NSString*) filePath
{
    
    NSError * erreur = nil;
    NSString * contenu = [NSString stringWithContentsOfFile:[self filePath]
                                                   encoding:NSUTF8StringEncoding
                                                      error:&erreur];
    return contenu;
        
}

/////////////////
//Permet de trasnferer le fichier de log vers le serveur de collecte des donnees
/////////////////

- (BOOL)uploadDataFile:(NSString *) fileName withFilePath:(NSString*) filePath
{
    
    //On definit l url du serveur cible
    NSString *url = @"";
    
    //On definit les data a envoyer en recuperant le fichier texte
    NSData* dataToSend = [[NSData alloc] initWithContentsOfFile:[self filePath]];
    
    //On definit la requete qui va etre emise
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    //On prepare les differents param de la requete
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n",fileName]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:dataToSend]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    //On execute la requete vers l url 
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    return ([returnString isEqualToString:@"OK"]);
}


///////////////
// Remise a zero des logs apres envoi au serveur
///////////////
-(void)clearFile:(NSString*)filePath
{
    NSString *temp = @"logs cleared";
    [temp writeToFile:[self filePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}


///////////////
// Definition des getters & setters pour filePath
///////////////

-(NSString*)filePath{
    return filePath;
}
- (void) setFilePath: (NSString*)newFilePath
{
    filePath = newFilePath;
}
/////////////

/*
///////////////
// Definition des getters & setters pour fileName
///////////////

-(NSString*)fileName{
    return fileName;
}
- (void) setFilePath: (NSString*)newFilePath
{
    filePath = newFilePath;
}
/////////////
 
 */

@end
