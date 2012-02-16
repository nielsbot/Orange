//
//  NSObject+Orange.h
//	Orange
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 DoubleDutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct objc_property *objc_property_t;

@interface NSObject (Orange)

+(objc_property_t)propertyAtKeyPath:(NSString*)keyPath ;

@end
