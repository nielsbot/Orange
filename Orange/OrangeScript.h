//
//  OrangeLayout.h
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * OrangeParserException ;


@class OrangeTrigger ;
@class OrangeBinding ;

@interface OrangeScript : NSObject

+(OrangeScript*)scriptWithFormat:(NSString*)script, ... ;
+(OrangeScript*)scriptWithFormat:(NSString*)script arguments:(va_list)argList ;

-(NSArray*)bindingsForTrigger:(NSString*)name ;	// if name is nil, returns unscoped bindings
//-(NSArray*)allBindings ;
//-(void)addBinding:(OrangeBinding*)binding forTrigger:(NSString*)name ;
//-(void)addBinding:(OrangeBinding*)binding ;

@end
