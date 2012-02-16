//
//  OrangeBinding.m
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import "OrangeBinding.h"
#import "OrangeExpression.h"
#import "OrangeTarget.h"

@implementation OrangeEvaluationContext
@synthesize target = _target ;
@synthesize contained = _contained ;

-(void)evaluate:(id)scope
{
	id target = self.target.baseObject ;
	if ( !target )
	{
		target = self.target.keypath.length > 0 ? [ scope valueForKeyPath:self.target.keypath ] : scope ;
	}
	
	if ( [ target conformsToProtocol:@protocol( NSFastEnumeration ) ] )
	{
		for( id obj in target )
		{
			[ self.contained makeObjectsPerformSelector:@selector( evaluate: ) withObject:obj ] ;
		}
	}
	else 
	{
		[ self.contained makeObjectsPerformSelector:@selector( evaluate: ) withObject:target ] ;
	}
}
@end

@implementation OrangeBinding

@synthesize expression = _expression ;

+(OrangeBinding*)bindingWithTarget:(OrangeTarget*)target expression:(OrangeExpression*)expr
{
	OrangeBinding * result = [ [ [ [ self class ] alloc ] init ] autorelease ] ;
	result.target = target ;
	result.expression = expr ;

	return result ;
}

+(NSSet *)keyPathsForValuesAffectingAssignTarget
{
	return [ NSSet setWithObjects:@"scope", @"target", nil ] ;
}

-(void)evaluate:(id)scope
{
	id target = self.target.baseObject ;
	if ( !target ) { target = scope ; }
	
	if ( [ scope conformsToProtocol:@protocol( NSFastEnumeration ) ])
	{
		for( id obj in scope )
		{
			[ obj setValue:[ self.expression result:obj ] forKeyPath:self.target.keypath ] ;
		}
	}
	else 
	{
		id value = [ self.expression result:target ] ;
		[ target setValue:value forKeyPath:self.target.keypath ] ;
	}
}

@end

#pragma mark -

@implementation OrangeTriggerScope
@synthesize triggers;

@end
