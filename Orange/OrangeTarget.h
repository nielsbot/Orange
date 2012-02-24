//
//  OrangeTarget.h
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 DoubleDutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrangeTarget : NSObject<NSCopying>

@property ( nonatomic, copy ) id (^getBaseObject)(id scope) ;
@property ( nonatomic, copy ) NSString * keypath ;

-(id)resolve:(id)scope ;

@end
