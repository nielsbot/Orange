//
//  OrangeTarget.h
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrangeTarget : NSObject

@property ( nonatomic, assign ) id baseObject ;
@property ( nonatomic, copy ) NSString * keypath ;

-(OrangeTarget*)initWithTarget:(id)target keypath:(NSString*)keypath ;

@end
