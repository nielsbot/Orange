//
//  NSObject+Orange.m
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import "NSObject+Orange.h"
#import <objc/runtime.h>

@implementation NSObject (Orange)

+(objc_property_t)propertyAtKeyPath:(NSString*)keyPath
{
	Class theClass = self ;
	objc_property_t prop = NULL ;
	
	for( NSString * key in [ keyPath componentsSeparatedByString:@"." ] )
	{
		prop = class_getProperty( theClass, [ key UTF8String ] ) ;
		char * t = property_copyAttributeValue( prop, "T" ) ;
		if ( t[0] == '@' )
		{
			NSString * nextClass = [ NSString stringWithUTF8String:t ] ;
			nextClass = [ nextClass substringWithRange:(NSRange){ 2, nextClass.length - 3 } ] ;
			
			theClass = NSClassFromString( nextClass ) ;
		}
		free( t ) ;
	}
	
	return prop ;
}

@end
