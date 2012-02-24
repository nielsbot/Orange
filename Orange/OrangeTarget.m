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

@synthesize getBaseObject = _getBaseObject ;
@synthesize keypath = _keypath ;

-(id)copyWithZone:(NSZone *)zone
{
	OrangeTarget * result = [ [ [ self class ] alloc ] init ] ;
	result.getBaseObject = self.getBaseObject ;
	result.keypath = self.keypath ;
	
	return result ;
}

-(NSString *)description
{
	return [ NSString stringWithFormat:@"%@<%p> { getBaseObject:%@<%p> keyPath:%@ }", [ self class ], self, [ self.getBaseObject class ], self.getBaseObject, self.keypath ] ;
}

-(void)dealloc
{
	self.getBaseObject = nil ;
	self.keypath = nil ;
	[ super dealloc ] ;
}

-(id)resolve:(id)scope
{
	return [ self.getBaseObject( scope ) valueForKeyPath:self.keypath ] ;
}

@end
