//
//  UIViewLayout.m
//  UIViewLayout
//
//  Created by Niels Gabel on 2/9/12.
//  Copyright (c) 2012 PlacePop. All rights reserved.
//

#import "UIViewLayout.h"
#import "y.tab.h"

extern void yyparse( yyscan_t scanner, id selfObject );
extern int yylex_init( yyscan_t * scanner ) ;
typedef struct YY_BUFFER_STATE * YY_BUFFER_STATE ;
YY_BUFFER_STATE yy_scan_string (const char * yystr , yyscan_t scanner);
void yy_delete_buffer (YY_BUFFER_STATE b ,yyscan_t yyscanner );
int yylex_destroy (yyscan_t yyscanner );

void yyerror( yyscan_t scanner, id selfObject, const char * error )
{
	NSLog(@"Error:%s\n", error) ;
}

@implementation LayoutRule

+(NSArray*)rulesWithString:(NSString*)string
{
	yyscan_t scanner = 0 ;
	yylex_init ( & scanner ) ;

	YY_BUFFER_STATE buffer =  yy_scan_string( [ string UTF8String ], scanner);
	yyparse( scanner, [ [ NSObject alloc ] init ] ) ;
	yy_delete_buffer ( buffer, scanner ) ;
	yylex_destroy ( scanner );
	
	return nil ;
}

@end
