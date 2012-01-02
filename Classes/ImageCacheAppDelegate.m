//
//  ImageCacheAppDelegate.m
//  ImageCache
//
//  Created by Faizan Aziz on 23/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageCacheAppDelegate.h"

@implementation ImageCacheAppDelegate

@synthesize window, pathField, nameField, imageView;


#pragma mark -
#pragma mark Application lifecycle

CFHashCode MyCallBack ( const void *value1 ){
	NSLog(@"Hello");
	return 200;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
	
    return YES;
}

- (IBAction)getImage{
	if( [pathField.text isEqualToString:@""] || [nameField.text isEqualToString:@""] ){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter details" message:@"Make sure path and name is entered" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	dispatch_async( dispatch_get_global_queue(0, 0), ^{
		
		UIImage *newImage = [BCImage imageWithURL:[NSURL URLWithString:pathField.text] withRelativePath:nameField.text];
		
		dispatch_async( dispatch_get_main_queue(), ^{
			imageView.image = newImage;
		});
	});
}

- (IBAction)clearText{
	pathField.text = nil;
	nameField.text = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	
	if( [textField isEqual:pathField] ){
		//Populate name field
		nameField.text = [pathField.text lastPathComponent];
	}
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
	
	NSLog(@"Warning received");
}


- (void)dealloc {
	[pathField release];
	[nameField release];
    [window release];
    [super dealloc];
}


@end
