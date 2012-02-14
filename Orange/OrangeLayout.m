//
//  OrangeLayout.m
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import "OrangeLayout.h"
#import "y.tab.h"

extern void yyparse( yyscan_t scanner, id selfObject, va_list argList, NSArray ** outRules );
extern int yylex_init( yyscan_t * scanner ) ;
typedef struct YY_BUFFER_STATE * YY_BUFFER_STATE ;
YY_BUFFER_STATE yy_scan_string (const char * yystr , yyscan_t scanner);
void yy_delete_buffer (YY_BUFFER_STATE b ,yyscan_t yyscanner );
int yylex_destroy (yyscan_t yyscanner );

void yyerror( yyscan_t scanner, id selfObject, va_list argList, NSArray ** outRules, const char * error )
{
	NSLog(@"Error:%s\n", error) ;
}

@interface OrangeLayout ()
@property ( nonatomic, copy ) NSArray * rules ;
@property ( nonatomic, assign ) NSArray * context ;

@end

@implementation OrangeLayout
@synthesize rules, context = _context ;

+(NSArray*)_compileOrangeScript:(NSString*)script arguments:(va_list)argList context:(id)context
{
	NSArray * rules = nil ;	// TODO make this an assignment object instead
	
	yyscan_t scanner = 0 ;
	yylex_init ( & scanner ) ;
	
	YY_BUFFER_STATE buffer =  yy_scan_string( [ script UTF8String ], scanner);
	yyparse( scanner, context, argList, & rules ) ;
	yy_delete_buffer ( buffer, scanner ) ;
	yylex_destroy ( scanner );

	return rules ;
}

+(OrangeLayout*)layoutWithScript:(NSString*)script arguments:(va_list)argList context:(id)context
{	
	OrangeLayout * result = [[[ OrangeLayout alloc ] init ] autorelease ] ;
	result.rules = [ self _compileOrangeScript:script arguments:argList context:context ] ;
	result.context = context ;
	return result ;
}

-(void)apply:(id)context
{
	[ self.rules enumerateObjectsUsingBlock:^(OrangeAssignment *  obj, NSUInteger idx, BOOL *stop) {
		[ obj assign:context ] ;
	}];
}

- (void)dealloc
{
    self.rules = nil ;
	self.context = nil ;
    [super dealloc];
}
@end
