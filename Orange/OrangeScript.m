//
//  OrangeScript.m
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import "OrangeScript_Private.h"
#import "y.tab.h"

NSString * OrangeParserException = @"OrangeParserException" ;

extern void yyparse( yyscan_t scanner, id selfObject, va_list argList, OrangeScript ** result );
extern int yylex_init( yyscan_t * scanner ) ;
typedef struct YY_BUFFER_STATE * YY_BUFFER_STATE ;
YY_BUFFER_STATE yy_scan_string (const char * yystr , yyscan_t scanner);
void yy_delete_buffer (YY_BUFFER_STATE b ,yyscan_t yyscanner );
int yylex_destroy (yyscan_t yyscanner );
void yyset_debug ( int flag, yyscan_t scanner );

void yyerror( yyscan_t scanner, id selfObject, va_list argList, OrangeScript ** outScript, const char * error )
{
	NSLog(@"Error:%s\n", error) ;
}

@implementation NSArray ( Orange )
-(NSArray*)flatten
{
	NSMutableArray * result = [ NSMutableArray array ] ;
	for( NSArray * array in self )
	{
		[ result addObjectsFromArray:array ] ;
	}
	
	return result ;
}
@end

@interface OrangeScript ()
@property ( nonatomic, copy ) NSArray * rules ;
@property ( nonatomic, assign ) NSArray * context ;
//@property ( nonatomic, retain ) NSMutableDictionary * bindingsByTrigger ;
@end

@implementation OrangeScript

@synthesize rules, context = _context ;
//@synthesize bindingsByTrigger = _bindingsByTrigger ;
@synthesize bindings ;

+(OrangeScript*)_compile:(NSString*)script arguments:(va_list)argList
{
	OrangeScript * result = nil ;
	
	yyscan_t scanner = 0 ;
	yylex_init ( & scanner ) ;
	yyset_debug ( 1, scanner );
	
	YY_BUFFER_STATE buffer =  yy_scan_string( [ script UTF8String ], scanner);
	yyparse( scanner, nil, argList, & result ) ;
	yy_delete_buffer ( buffer, scanner ) ;
	yylex_destroy ( scanner );

	return result ;
}

+(OrangeScript*)scriptWithFormat:(NSString*)script arguments:(va_list)argList
{	
	OrangeScript * result = [ self _compile:script arguments:argList ] ;
	return result ;
}

+(OrangeScript*)scriptWithFormat:(NSString*)script, ...
{
	va_list argList ;
	va_start(argList, script);
	OrangeScript * result = [ self scriptWithFormat:script arguments:argList ] ;
	va_end(argList);
	
	return result ;
}

- (void)dealloc
{
    self.rules = nil ;
	self.context = nil ;
    [super dealloc];
}

-(NSArray*)bindingsForTrigger:(NSString*)name
{
	NSMutableArray * result = [ NSMutableArray array ] ;
	for( OrangeBinding * binding in self.bindings )
	{
		if ( [binding isKindOfClass:[ OrangeTriggerScope class ] ] )
		{
			if ([ ((OrangeTriggerScope*)binding).triggers containsObject:name ] )
			{
				[ result addObject:binding ] ;
			}
		}
	}
	return result ;
}

//
//-(NSArray*)allBindings
//{
//	return [[ self.bindingsByTrigger allValues ] flatten ] ;
//}
//
//-(void)addBinding:(OrangeBinding*)binding forTrigger:(NSString*)name
//{
//	id key = name.length > 0 ? name : [ NSNull null ] ;
//	
//	NSMutableArray * array = [self.bindingsByTrigger objectForKey:key ] ;
//	if ( !array ) { array = [ NSMutableArray array ] ; }
//	[ array addObject:binding ] ;
//	
//	[ self.bindingsByTrigger setObject:array forKey:key ] ;
//}
//
//-(void)addBinding:(OrangeBinding*)binding
//{
//	[ self addBinding:binding forTrigger:nil ] ;
//}


@end
