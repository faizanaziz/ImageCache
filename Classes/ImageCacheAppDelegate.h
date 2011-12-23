//
//  ImageCacheAppDelegate.h
//  ImageCache
//
//  Created by Faizan Aziz on 23/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCImage.h"

@interface ImageCacheAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	IBOutlet UITextField *pathField;
	IBOutlet UITextField *nameField;
	IBOutlet UIImageView *imageView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITextField *pathField;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

- (IBAction)getImage;
- (IBAction)clearText;


@end

