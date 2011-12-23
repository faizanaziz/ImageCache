//
//  BCImage.h
//  ImageCache
//
//  Created by Faizan Aziz on 23/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BCImage : NSObject {

}

+ (UIImage*)imageRelativePath:(NSString*)aPath;
+ (UIImage*)imageWithURL:(NSURL*)aURL withRelativePath:(NSString*)aPath;

@end
