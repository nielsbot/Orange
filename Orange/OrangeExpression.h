//
//  OrangeExpression.h
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 DoubleDutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OrangeExpression : NSObject

+(OrangeExpression*)expressionWithEvaluator:(id(^)(id scope))block ;
+(OrangeExpression*)expressionWithFloatEvaluator:(float(^)(id scope))block ;
+(OrangeExpression*)expressionWithSizeEvaluator:(CGSize(^)(id scope))block ;
+(OrangeExpression*)expressionWithRectEvaluator:(CGRect(^)(id scope))block ;
-(id)result:(id)scope ;
-(float)floatResult:(id)scope ;	// may be more efficient than -result
-(CGSize)sizeResult:(id)scope ;
-(CGRect)rectResult:(id)scope ;

@end

@interface OrangeConstant : OrangeExpression

-(id)initWithValue:(id<NSCopying>)value ;

@end
