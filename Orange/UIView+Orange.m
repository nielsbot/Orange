//
//  UIView+Orange.m
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 PlacePop. All rights reserved.
//

#import "UIView+Orange.h"
#import "OrangeLayoutPrivate.h"
#import "OrangeTrigger.h"
#import "OrangeScript.h"

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static IMP sUIViewLayoutSubviews = NULL ;
static void OrangeLayoutSubviews( UIView * self, SEL _cmd ) ;

@implementation UIView (Orange)
@dynamic orangeScript, top, left, right, bottom, height, width;

+(void)initOrange
{
	sUIViewLayoutSubviews = class_replaceMethod( self, @selector( layoutSubviews ), (IMP)OrangeLayoutSubviews, "v@:" ) ;
}

-(void)setLayoutWithOrangeScript:(NSString*)orangeLayoutScript, ...
{
	va_list argList = NULL ;
	va_start( argList, orangeLayoutScript ) ;
	self.orangeScript = [ OrangeScript scriptWithFormat:orangeLayoutScript 
											   arguments:(va_list)argList ] ;
	va_end( argList ) ;
}

-(void)setOrangeScript:(OrangeScript *)orangeLayout
{
	[ self.layer setValue:orangeLayout forKey:@"orangeLayout" ] ;
}

-(OrangeScript*)orangeScript
{
	return [ self.layer valueForKey:@"orangeLayout" ] ;
}

-(CGFloat)top
{
	return CGRectGetMinY( self.frame ) ;
}

-(void)setTop:(CGFloat)top
{
	CGRect r = self.frame ;
	r.size.height -= top - CGRectGetMinY( r ) ;
	r.origin.y = top ;
	
	self.frame = r ;
}

-(CGFloat)bottom
{
	return CGRectGetMaxY( self.frame ) ;
}

-(void)setBottom:(CGFloat)bottom
{
	CGRect r = self.frame ;
	r.size.height = bottom - CGRectGetMinY( r ) ;
	self.frame = r ;
}

-(CGFloat)left
{
	return CGRectGetMinX( self.frame ) ;
}

-(void)setLeft:(CGFloat)left
{
	CGRect r = self.frame ;
	r.size.width -= CGRectGetMinX( r ) - left ;
	r.origin.x = left ;
	self.frame = r ;
}

-(CGFloat)right
{
	return CGRectGetMaxX( self.frame ) ;
}

-(void)setRight:(CGFloat)right
{
	CGRect r = self.frame ;
	r.size.width = right - CGRectGetMinX( r ) ;
	self.frame = r ;
}

-(CGFloat)height
{
	return self.frame.size.height ;
}

-(void)setHeight:(CGFloat)height
{
	CGRect r = self.frame ;
	r.size.height = height ;
	self.frame = r;
}

-(CGFloat)width
{
	return self.frame.size.width ;
}

-(void)setWidth:(float)width
{
	CGRect r = self.frame ;
	r.size.width = width ;
	self.frame = r;
}

@end

static void OrangeLayoutSubviews( UIView * self, SEL _cmd )
{
	(*sUIViewLayoutSubviews)(self, _cmd) ;
	OrangeScript * script = self.orangeScript;
	NSArray * bindings = [ script bindingsForTrigger:@"layout" ] ;
	
	if ( bindings ) 
	{
		[ bindings makeObjectsPerformSelector:@selector( evaluate ) ] ;
	}
}
