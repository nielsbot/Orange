//
//  OrangeTarget.h
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 DoubleDutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrangeTarget : NSObject<NSCopying>

@property ( nonatomic, assign ) id baseObject ;
@property ( nonatomic, copy ) NSString * keypath ;

-(OrangeTarget*)initWithTarget:(id)target keypath:(NSString*)keypath ;

@end
