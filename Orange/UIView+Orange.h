//
//  UIView+Orange.h
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrangeScript.h"

@class OrangeScript ;

@interface UIView (Orange)

@property ( nonatomic, retain ) OrangeScript * orangeScript ;

// layout helpers: (adjust on frame property, not bounds)
@property ( nonatomic, readonly ) CGFloat top ;
@property ( nonatomic, readonly ) CGFloat bottom ;
@property ( nonatomic ) CGFloat left ;
@property ( nonatomic ) CGFloat right ;
@property ( nonatomic ) CGFloat width ;
@property ( nonatomic ) CGFloat height ;

+(void)initOrange ;
-(void)setLayoutWithOrangeScript:(NSString*)orangeLayoutScript, ... NS_FORMAT_FUNCTION(1,2);

@end
