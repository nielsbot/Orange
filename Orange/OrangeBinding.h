//
//  OrangeBinding.h
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrangeExpression ;
@class OrangeTarget ;
@class OrangeTriggerScope;
@class OrangeBindingScope ;

@interface OrangeBinding : NSObject
@property ( nonatomic, retain ) OrangeExpression * expression ;
@property ( nonatomic, retain ) OrangeTarget * target ;
@property ( nonatomic, assign ) OrangeBindingScope * scope ;

-(void)evaluate ;

@end

@interface OrangeBindingScope : OrangeBinding
@property ( nonatomic, retain ) NSArray * contained ;

@end

@interface OrangeTriggerScope : OrangeBindingScope
@property ( nonatomic, retain ) NSArray * triggers ;
@end
