//
//  OrangeTarget.m
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 PlacePop. All rights reserved.
//

#import "OrangeTarget.h"

@interface OrangeTarget ()
@end

@implementation OrangeTarget

@synthesize baseObject = _baseObject ;
@synthesize keypath = _keypath ;

-(OrangeTarget*)initWithTarget:(id)target keypath:(NSString*)keypath
{
	if (( self = [ super init ] ))
	{
		self.baseObject = target ;
		self.keypath = keypath ;		
	}
	
	return self ;
}

-(void)dealloc
{
	self.baseObject = nil ;
	self.keypath = nil ;

	[ super dealloc ] ;
}

-(void)setBaseObject:(id)baseObject
{
	_baseObject = baseObject ;
}

-(void)setKeypath:(NSString *)keypath
{
	_keypath = [ keypath copy ] ;
}

@end
