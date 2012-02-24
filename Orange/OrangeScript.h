//
//  OrangeLayout.h
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 DoubleDutch Inc. All rights reserved.
//

#import "OrangeBinding.h"

extern NSString * OrangeParserException ;


@class OrangeTrigger ;
@class OrangeBinding ;

@interface OrangeScript : OrangeEvaluationContext

+(OrangeScript*)scriptWithFormat:(NSString*)script, ... ;
+(OrangeScript*)scriptWithFormat:(NSString*)script arguments:(va_list)argList ;

-(NSArray*)bindingsForTrigger:(NSString*)name ;	// if name is nil, returns unscoped bindings
//-(NSArray*)allBindings ;
//-(void)addBinding:(OrangeBinding*)binding forTrigger:(NSString*)name ;
//-(void)addBinding:(OrangeBinding*)binding ;
-(void)bind:(id)contextObject ;

@end
