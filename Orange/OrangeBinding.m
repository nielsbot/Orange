//
//  OrangeBinding.m
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 DoubleDutch Inc. All rights reserved.
//

#import "OrangeBinding.h"
#import "OrangeExpression.h"
#import "OrangeTarget.h"

@implementation OrangeEvaluationContext
@synthesize target = _target ;
@synthesize contained = _contained ;

-(void)evaluate:(id)scope
{
	id assignTarget = self.target ? [ self.target resolve:scope ] : scope ;
	
	[ self.contained makeObjectsPerformSelector:@selector( evaluate: ) 
									 withObject:assignTarget ] ;
}
@end

@implementation OrangeBinding

@synthesize expression = _expression ;

-(void)evaluate:(id)scope
{
	id assignTarget = self.target.getBaseObject ? self.target.getBaseObject( scope ) : scope ;
	
	
	if ( [ assignTarget conformsToProtocol:@protocol( NSFastEnumeration ) ])
	{
		for( id obj in scope )
		{
			[ obj setValue:[ self.expression result:obj ] forKeyPath:self.target.keypath ] ;
		}
	}
	else 
	{
		id value = [ self.expression result:assignTarget ] ;
		[ assignTarget setValue:value forKeyPath:self.target.keypath ] ;
	}
}

@end

#pragma mark -

@implementation OrangeTriggerScope
@synthesize triggers;

@end
