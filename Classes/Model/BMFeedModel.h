//
//  BMFeedModel.h
//  BuildMobileThree20
//
//  Created by Ben Morrall on 18/05/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Three20/Three20.h>

@interface BMFeedModel : TTURLRequestModel {
	NSString *rssFeed;
	NSArray *items;
}

@property (nonatomic, retain) NSArray *items;

- (id)initWithRSSFeed:(NSString*)rssFeed;

@end
