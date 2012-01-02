//
//  WeakRefHolder.h
//  ImageCache
//
//  Created by Faizan Aziz on 30/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//This  class is not really a weak referrence holder. It is used to hold a ref temp and is not really a good method. The idea is to have a CFDictionary with weak ref to do this at a later stage

#import <Foundation/Foundation.h>


@interface WeakRefHolder : NSObject {
	NSMutableDictionary *holdingDictionary;

}

- (id)objectForKey:(id)aKey;
- (void)setObject:(id)anObject forKey:(id)aKey;
- (void)removeObjectForKey:(id)aKey;
- (void)removeObject:(id)aObject;
- (NSArray*)allKeys;

@end
