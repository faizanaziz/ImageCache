//
//  BCImage.h
//  ImageCache
//
//  Created by Faizan Aziz on 23/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeakRefHolder.h"

@interface BCImage : UIImage {
	
}

+ (UIImage*)imageRelativePath:(NSString*)aPath;
+ (UIImage*)imageWithURL:(NSURL*)aURL withRelativePath:(NSString*)aPath;

@end
