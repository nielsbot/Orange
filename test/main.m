//
//  main.m
//  test
//
//  Created by Niels Gabel on 2/13/12.
//  Copyright (c) 2012 nielsbot. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "UIView+Orange.h"

int main(int argc, char *argv[])
{
	@autoreleasepool {
		[ UIView initOrange ] ;

	    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	}
}
