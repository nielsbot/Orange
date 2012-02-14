//
//  OrangeExpression.m
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import "OrangeExpression.h"

@interface OrangeExpression ()
@property ( nonatomic, copy ) id (^evaluator)(id scope) ;
@property ( nonatomic, copy ) float (^floatEvaluator)(id scope) ;
@property ( nonatomic, copy ) CGSize (^sizeEvaluator)(id scope) ;
@property ( nonatomic, copy ) CGRect (^rectEvaluator)(id scope) ;
@end

@implementation OrangeExpression

@synthesize evaluator = _evaluator ;
@synthesize floatEvaluator = _floatEvaluator ;
@synthesize sizeEvaluator = _sizeEvaluator ;
@synthesize rectEvaluator = _rectEvaluator ;

+(OrangeExpression*)expressionWithEvaluator:(id(^)(id scope))block
{
	OrangeExpression * result = [ [ [ [ self class ] alloc ] init ] autorelease ] ;

	result.evaluator = block ;
	return result ;
}

+(OrangeExpression*)expressionWithFloatEvaluator:(float(^)(id scope))block
{
	if ( !block ) { return nil ; }
	
	OrangeExpression * result = [ [ [ [ self class ] alloc ] init ] autorelease ] ;
	
	result.floatEvaluator = block ;
	
	return result ;
}

+(OrangeExpression*)expressionWithSizeEvaluator:(CGSize(^)(id scope))block
{
	if ( !block ) { return nil ; }
	OrangeExpression * result = [ [ [ [ self class ] alloc ] init ] autorelease ] ;
	result.sizeEvaluator = block ;

	return result ;
}

+(OrangeExpression*)expressionWithRectEvaluator:(CGRect(^)(id scope))block
{
	if ( !block ) { return nil ; }
	OrangeExpression * result = [ [ [ [ self class ] alloc ] init ] autorelease ] ;
	result.rectEvaluator = block ;
	
	return result ;
}

-(id)result:(id)scope
{
	return self.evaluator ? self.evaluator(scope) : [ NSNull null ] ;
}

-(float)floatResult:(id)scope
{
	return self.floatEvaluator ? self.floatEvaluator(scope) : [ [ self result:scope ] floatValue ] ;
}

-(CGSize)sizeResult:(id)scope
{
	return self.sizeEvaluator ? self.sizeEvaluator(scope) : [ [ self result:scope ] CGSizeValue ] ;
}

-(CGRect)rectResult:(id)scope
{
	return self.rectEvaluator ? self.rectEvaluator(scope) : [ [ self result:scope ] CGRectValue ] ;
}

@end

@interface OrangeConstant ()
@property ( nonatomic, copy ) id<NSObject> value ;
@end

@implementation OrangeConstant : OrangeExpression
@synthesize value = _value ;

-(id)initWithValue:(id<NSCopying>)value
{
	if (( self = [ super init ] ))
	{
		self.value = [ value copyWithZone:nil ] ;
	}
	return self ;
}

-(id)result:(id)scope
{
	return self.value ;
}

@end
