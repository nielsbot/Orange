//
//  OrangeLayout.h
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrangeLayout : NSObject

+(OrangeLayout*)layoutWithScript:(NSString*)script arguments:(va_list)argList context:(id)context ;

@end
