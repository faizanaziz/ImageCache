//
//  SpecialMutableDictionary.m
//  ImageCache
//
//  Created by Faizan Aziz on 30/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WeakRefHolder.h"


@implementation WeakRefHolder

- (id)init{
	if( self = [super init] ){
		holdingDictionary = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)dealloc{
	[holdingDictionary release];
	[super dealloc];
}

- (id)objectForKey:(id)aKey{
	return [holdingDictionary objectForKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id)aKey{
	[holdingDictionary setObject:anObject forKey:aKey];
	[anObject release];
}

- (void)removeObjectForKey:(id)aKey{
	id object = [holdingDictionary objectForKey:aKey];
	[object retain];
	[holdingDictionary removeObjectForKey:aKey];
}

- (void)removeObject:(id)aObject{
	for( NSString *key in [holdingDictionary allKeys] ){
		id object = [holdingDictionary objectForKey:key];
		if ( [object isEqual:aObject] )
			[self removeObjectForKey:key];
	}
}

- (NSArray*)allKeys{
	return [holdingDictionary allKeys];
}

@end
