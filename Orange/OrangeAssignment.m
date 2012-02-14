//
//  OrangeAssignment.m
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import "OrangeAssignment.h"
#import "OrangeExpression.h"
#import "OrangeTarget.h"

@interface OrangeAssignment ()
@property ( nonatomic, retain ) OrangeTarget * target ;
@property ( nonatomic, retain ) OrangeExpression * expression ;
@end

@implementation OrangeAssignment

@synthesize target = _target ;
@synthesize expression = _expression ;

+(OrangeAssignment*)assignmentWithTarget:(OrangeTarget*)target expression:(OrangeExpression*)expr
{
	OrangeAssignment * result = [ [ [ [ self class ] alloc ] init ] autorelease ] ;
	result.target = target ;
	result.expression = expr ;

	return result ;
}

-(void)assign:(id)scopeObject
{
	id baseObject = self.target.baseObject ;
	if ( !baseObject ) { baseObject = scopeObject ; }

	[ baseObject setValue:[ self.expression result:scopeObject ] forKeyPath:self.target.keypath ] ;
}


@end

#pragma mark -

@interface OrangeAssignmentGroup ()
@property ( nonatomic, retain ) NSArray * assignments ;
@end

@implementation OrangeAssignmentGroup

@synthesize assignments = _assignments ;

+(OrangeAssignmentGroup*)groupWithTarget:(OrangeTarget*)target assignments:(NSArray*)assignments
{
	OrangeAssignmentGroup * result = [ [ [ [ self class ] alloc ] init ] autorelease ] ;
	result.target = target ;
	result.assignments = assignments ;
	return result ;
}

-(void)assign:(id)scopeObject
{
	id t = self.target.baseObject ;
	if ( !t) { t = scopeObject ; }
	if ( self.target.keypath.length > 0 )
	{
		t = [ t valueForKeyPath:self.target.keypath ] ;
	}
	
	[ self.assignments makeObjectsPerformSelector:@selector( assign: ) withObject:t ] ;
}

@end
