//
//  OrangeAssignment.h
//  UIViewLayout
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrangeExpression ;
@class OrangeTarget ;

@interface OrangeAssignment : NSObject

+(OrangeAssignment*)assignmentWithTarget:(OrangeTarget*)target expression:(OrangeExpression*)expr ;
-(void)assign:(id)scopeObject ;

@end

@interface OrangeAssignmentGroup : OrangeAssignment

+(OrangeAssignmentGroup*)groupWithTarget:(OrangeTarget*)target assignments:(NSArray*)assignments ;

@end
