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
static IMP sUIViewDidAddSubview = NULL ;
static IMP sUIViewSetNilValueForKey = NULL ;

//static IMP sUIViewDidMoveToSuperview = NULL ;
//static IMP sUIViewSetSuperview = NULL ;
//static IMP sUIViewAwakeFromNib = NULL ;

static void OrangeLayoutSubviews( UIView * self, SEL _cmd ) ;
static void OrangeViewDidAddSubview( UIView * self, SEL _cmd, UIView * subview ) ;
static void OrangeViewSetNilValueForKey( UIView * self, SEL _cmd, NSString * key ) ;

@interface UIView (OrangePrivate)
@end

@implementation UIView (Orange)
@dynamic orangeScript, top, left, right, bottom, height, width, next, previous;

+(void)initOrange
{
	sUIViewLayoutSubviews = class_replaceMethod( self, @selector( layoutSubviews ), (IMP)OrangeLayoutSubviews, "v@:" ) ;
	sUIViewDidAddSubview = class_replaceMethod( self, @selector( didAddSubview: ), (IMP)OrangeViewDidAddSubview, "v@:@" ) ;
	//	sUIViewDidMoveToSuperview = class_replaceMethod( self, @selector( didMoveToSuperview ), (IMP)OrangeViewDidMoveToSuperview, "v@:" ) ;
	//	sUIViewSetSuperview = class_replaceMethod( self, @selector( setSuperview: ), (IMP)OrangeViewSetSuperview, "v@:@" ) ;
	//	sUIViewAwakeFromNib = class_replaceMethod( self, @selector( initWithCoder: ), (IMP)OrangeViewInitWithCoder, "v@:@" ) ;
	sUIViewSetNilValueForKey = class_replaceMethod( self, @selector( setNilValueForKey: ), (IMP)OrangeViewSetNilValueForKey, "@:@" ) ;
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
	r.origin.y = bottom - r.size.height ;
	self.frame = r ;
}

-(CGFloat)left
{
	return CGRectGetMinX( self.frame ) ;
}

-(void)setLeft:(CGFloat)left
{
	CGRect r = self.frame ;
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
	r.origin.x = right - r.size.width ;
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

-(UIView *)previous
{
	id result = [ self.layer valueForKey:@"previous" ] ;
	return result ;
}

-(void)setPrevious:(UIView *)previous
{
	[ self.layer setValue:previous forKey:@"previous" ] ;
}

-(UIView *)next
{
	return [ self.layer valueForKey:@"next" ] ;
}

-(void)setNext:(UIView *)next
{
	[ self.layer setValue:next forKey:@"next" ] ;
}

//-(void)setPreviousNextLinksValid:(BOOL)b
//{
//	[self.layer setValue:[ NSNumber numberWithBool:b ] forKey:@"previousNextLinksValid" ] ;
//}
//
//-(BOOL)previousNextLinksValid
//{
//	return [[self.layer valueForKey:@"previousNextLinksValid" ] boolValue ] ;
//}

@end

static void OrangeLayoutSubviews( UIView * self, SEL _cmd )
{
	(*sUIViewLayoutSubviews)(self, _cmd) ;
	
	//	if ( !self.previousNextLinksValid )
	//	{
	//		UIView * previous = nil ;
	//		for( UIView * view in self.subviews )
	//		{
	//			view.previous = previous ;
	//			previous = view ;
	//		}
	//		self.previousNextLinksValid = YES ;
	//	}
	OrangeScript * script = self.orangeScript;
	NSArray * bindings = [ script bindingsForTrigger:@"layout" ] ;
	
	if ( bindings ) 
	{
		[ bindings makeObjectsPerformSelector:@selector( evaluate: ) withObject:self ] ;
	}
}

static void OrangeViewDidAddSubview( UIView * self, SEL _cmd, UIView * subview )
{
	if ( sUIViewDidAddSubview ) { (*sUIViewDidAddSubview)(self, _cmd, subview) ; }
	
	UIView * previous = nil ;
	for( UIView * view in self.subviews )
	{
		view.previous = previous ;
		previous = view ;
	}
}

//static void OrangeViewDidMoveToSuperview( UIView * self, SEL _cmd ) 
//{
//	if ( sUIViewDidMoveToSuperview ) { (*sUIViewDidMoveToSuperview)( self, _cmd ) ; }
//}
//
//static void OrangeViewSetSuperview( UIView * self, SEL _cmd, UIView * superview )
//{
//	if ( sUIViewSetSuperview ) { (*sUIViewSetSuperview)( self, _cmd, superview ) ; }
//		
//}

//static void OrangeViewInitWithCoder( UIView * self, SEL _cmd, NSKeyedUnarchiver * decoder )
//{
//	if ( sUIViewAwakeFromNib ) { (*sUIViewAwakeFromNib)(self, _cmd, decoder ) ; }
//
//	UIView * previous = nil ;
//	for( UIView * view in self.subviews )
//	{
//		view.previous = previous ;
//		previous = view ;
//	}
//}

static void OrangeViewSetNilValueForKey( UIView * self, SEL _cmd, NSString * key )
{
	objc_property_t prop = class_getProperty( [ self class ], [ key UTF8String ] ) ;
	if ( prop )
	{
		const char * type = property_copyAttributeValue( prop, "T" ) ;
		switch( type[0] )
		{
			case 'c':
			case 'i':
			case 's':
			case 'l':
			case 'q':
			case 'C':
			case 'I':
			case 'L':
			case 'Q':
			case 'f':
			case 'd':
			{
				[ self setValue:[ NSNumber numberWithInteger:0 ] forKey:key ] ;
				break ;
			}
		}				
	}
}
