//
//  UIView+Orange.h
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 PlacePop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrangeLayout.h"

@class OrangeLayout ;

@interface UIView (Orange)
@property ( nonatomic, retain ) OrangeLayout * orangeLayout ;
@property ( nonatomic, readonly ) CGFloat top ;
@property ( nonatomic, readonly ) CGFloat bottom ;
@property ( nonatomic ) CGFloat left ;
@property ( nonatomic ) CGFloat right ;
@property ( nonatomic ) CGFloat width ;
@property ( nonatomic ) CGFloat height ;

+(void)initOrange ;
-(void)setLayoutWithOrangeScript:(NSString*)orangeLayoutScript, ... NS_FORMAT_FUNCTION(1,2);

@end