//
//  OrangeTarget.m
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 DoubleDutch Inc. All rights reserved.
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

-(id)copyWithZone:(NSZone *)zone
{
	OrangeTarget * result = [ [ [ self class ] alloc ] init ] ;
	result.baseObject = self.baseObject ;
	result.keypath = self.keypath ;
	
	return result ;
}

-(NSString *)description
{
	return [ NSString stringWithFormat:@"%@<%p> { baseObject:%@<%p> keyPath:%@ }", [ self class ], self, [ self.baseObject class ], self.baseObject, self.keypath ] ;
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
