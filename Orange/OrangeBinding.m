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

@interface OrangeBinding ()
@property ( nonatomic, retain ) OrangeTarget * assignTarget ;

@end

@implementation OrangeBinding

@synthesize target = _target ;
@synthesize expression = _expression ;
@synthesize scope = _scope ;
@synthesize assignTarget = _assignTarget ;

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

-(void)evaluate
{
	OrangeTarget * target = self.assignTarget ;
	
	[ target.baseObject setValue:[ self.expression result:self.scope ] forKeyPath:target.keypath ] ;
}

-(void)setScope:(OrangeBindingScope *)scope
{
	_scope = scope ;
	self.assignTarget = nil ;
}

-(void)setTarget:(OrangeTarget *)target
{
	[ _target release ] ;
	_target = [ target retain ] ;
	
	self.assignTarget = nil ;
}

-(OrangeTarget*)assignTarget
{
	if ( !_assignTarget )
	{
		OrangeTarget * target = nil ;
		
		if ( self.scope )
		{
			target = self.scope.assignTarget ;
		}

		if ( target )
		{
			target = [[ target copy ] autorelease ] ;
			NSString * keypath = target.keypath ;
			keypath = keypath ? [ keypath stringByAppendingFormat:@".%@", self.target.keypath ] : self.target.keypath ;
			
			target.keypath = keypath ;
		}
		else 
		{
			target = self.target ;
		}
		
		_assignTarget = [ target retain ] ;
	}
	
	return _assignTarget ;
}

@end

#pragma mark -

@implementation OrangeBindingScope
@synthesize contained = _contained ;

-(void)evaluate
{
	[ self.contained makeObjectsPerformSelector:@selector( evaluate ) ] ;
}

-(void)setContained:(NSArray *)array
{
	[ _contained autorelease ] ;
	_contained = [ array retain ] ;
	
	[ array setValue:self forKey:@"scope" ] ;
}

@end

@implementation OrangeTriggerScope
@synthesize triggers;

@end
