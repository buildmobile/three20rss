//
//  BMFeedItem.m
//  BuildMobileThree20
//
//  Created by Ben Morrall on 18/05/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "BMFeedItem.h"

#import <Three20/Three20.h>


@implementation BMFeedItem

@synthesize title, description, link, publishedDate;

- (void)dealloc {
	TT_RELEASE_SAFELY(title);
	TT_RELEASE_SAFELY(description);
	TT_RELEASE_SAFELY(link);
	TT_RELEASE_SAFELY(publishedDate);
	[super dealloc];
}

@end
