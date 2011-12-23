//
//  BCImage.m
//  ImageCache
//
//  Created by Faizan Aziz on 23/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BCImage.h"


@implementation BCImage

static NSMutableDictionary *imageDictionary;
static NSString *commonPath;
static id observer;

+ (void)assignDefaults{
	if( imageDictionary == nil ){
		observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification){
			[imageDictionary removeAllObjects];
			[imageDictionary release];
			imageDictionary = nil;
			
			[[NSNotificationCenter defaultCenter] removeObserver:observer];
		}];
		imageDictionary = [[NSMutableDictionary alloc] init];
	}
	
	if ( commonPath == nil ){
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		commonPath = [[NSString alloc] initWithString:[paths objectAtIndex:0] ];
	}
}

+ (UIImage*)imageRelativePath:(NSString*)aPath{
	[BCImage assignDefaults];
	
	UIImage *imageForPath = [imageDictionary objectForKey:aPath];
	if( imageForPath != nil )
		return imageForPath;
	
	NSString *absolutePath = [[NSString alloc] initWithFormat:@"%@/%@", commonPath, aPath];
	imageForPath = [[UIImage alloc] initWithContentsOfFile:absolutePath];
	[absolutePath release];
	
	[imageDictionary setObject:imageForPath forKey:aPath];
	[imageForPath release];
	return imageForPath;
}

+ (UIImage*)imageWithURL:(NSURL*)aURL withRelativePath:(NSString*)aPath{
	[BCImage assignDefaults];
	
	NSString *absolutePath = [[NSString alloc] initWithFormat:@"%@/%@", commonPath, aPath];
	UIImage *image;
	
	NSAutoreleasePool *autoreleasePool = [[NSAutoreleasePool alloc] init];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if( ! [fileManager fileExistsAtPath:absolutePath] ){
		NSURLResponse *response;
		
		//Download and retry
		NSURLRequest *imageRequest = [NSURLRequest requestWithURL:aURL];
		NSData *imageData = [NSURLConnection sendSynchronousRequest:imageRequest returningResponse:&response error:nil];
		if(imageData != nil ){
			[imageData writeToFile:absolutePath atomically:YES];
			image = [[UIImage alloc] initWithData:imageData];
			[imageDictionary setObject:image forKey:aPath];
			[image release];
		}
	}
	else{
		image = [imageDictionary objectForKey:aPath];
		if( image == nil ){
			image = [[UIImage alloc] initWithContentsOfFile:absolutePath];
			[imageDictionary setObject:image forKey:aPath];
			[image release];
		}
	}
	
	[autoreleasePool drain];
	[absolutePath release];
	return image;
}

@end
