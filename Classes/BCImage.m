//
//  BCImage.m
//  ImageCache
//
//  Created by Faizan Aziz on 23/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BCImage.h"


@implementation BCImage

static NSMutableArray *imageCacheArray;
static NSString *commonPath;
static id observer;
static WeakRefHolder *refHolder;

+ (void)assignDefaults{
	if( refHolder == nil )
		refHolder = [[WeakRefHolder alloc] init];
	
	if( imageCacheArray == nil ){
		observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification){
			
			//Free memory
			[imageCacheArray removeAllObjects];
			
			//Clean up
			[imageCacheArray release];
			imageCacheArray = nil;
			
			[commonPath release];
			commonPath = nil;
			
			if( [[refHolder allKeys] count] == 0 ){
				[refHolder release];
				refHolder = nil;
			}
			
			[[NSNotificationCenter defaultCenter] removeObserver:observer];
		}];
		imageCacheArray = [[NSMutableArray alloc] init];
	}
	
	if ( commonPath == nil ){
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		commonPath = [[NSString alloc] initWithString:[paths objectAtIndex:0] ];
	}
}

+ (UIImage*)imageRelativePath:(NSString*)aPath{
	[BCImage assignDefaults];
	
	//(UIImage*)CFDictionaryGetValue(refHolder, aPath);//[imageDictionary objectForKey:aPath];
	UIImage *imageForPath = [refHolder objectForKey:aPath];
	if( imageForPath != nil )
		return imageForPath;
	
	NSString *absolutePath = [[NSString alloc] initWithFormat:@"%@/%@", commonPath, aPath];
	imageForPath = [[UIImage alloc] initWithContentsOfFile:absolutePath];
	[absolutePath release];
	
	[imageCacheArray addObject:imageForPath];
	[refHolder setObject:imageForPath forKey:aPath];
	//CFDictionarySetValue(refHolder, aPath, imageForPath);
	//[imageDictionary setObject:imageForPath forKey:aPath];
	[imageForPath release];
	return imageForPath;
}

+ (UIImage*)imageWithURL:(NSURL*)aURL withRelativePath:(NSString*)aPath{
	[BCImage assignDefaults];
	
	NSString *absolutePath = [[NSString alloc] initWithFormat:@"%@/%@", commonPath, aPath];
	BCImage *image = nil;
	
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
			[imageCacheArray addObject:image];
			[refHolder setObject:image forKey:aPath];
			[image release];
		}
	}
	else{
		image = [refHolder objectForKey:aPath];
		if( image == nil ){
			image = [[BCImage alloc] initWithContentsOfFile:absolutePath];
			[imageCacheArray addObject:image];
			[refHolder setObject:image forKey:aPath];
			[image release];
		}
	}
	
	[autoreleasePool drain];
	[absolutePath release];
	
	return image;
}

- (void)dealloc{
	NSLog(@"Something got destroyed so unregisterning it from ref holder");
	[refHolder removeObject:self];
	
	[super dealloc];
}

@end
