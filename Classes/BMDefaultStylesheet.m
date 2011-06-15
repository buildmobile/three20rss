//
//  BMDefaultStylesheet.m
//  BuildMobileThree20
//
//  Created by Ben Morrall on 19/05/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "BMDefaultStylesheet.h"


@implementation BMDefaultStylesheet

// Change the Tint to match BuildMobile's Black Tint
- (UIColor*)navigationBarTintColor { 
	NSLog(@"Color is %f", 39.0/255);
    return [UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha: 1.0]; 
}

- (UIColor*)toolbarTintColor { 
    return [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha: 1.0]; 
}

@end
