//
//  OrangeBinding.h
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrangeExpression ;
@class OrangeTarget ;
@class OrangeTriggerScope;
@class OrangeBindingScope ;

@interface OrangeEvaluationContext : NSObject

@property ( nonatomic, retain ) OrangeTarget * target ;
@property ( nonatomic, retain ) NSArray * contained ;

-(void)evaluate:(id)scope ;

@end

@interface OrangeBinding : OrangeEvaluationContext

@property ( nonatomic, retain ) OrangeExpression * expression ;

@end

@interface OrangeTriggerScope : OrangeEvaluationContext
@property ( nonatomic, retain ) NSArray * triggers ;
@end
