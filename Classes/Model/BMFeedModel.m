//
//  BMFeedModel.m
//  BuildMobileThree20
//
//  Created by Ben Morrall on 18/05/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "BMFeedModel.h"

#import <extThree20XML/extThree20XML.h>
#import "BMFeedItem.h"

@implementation BMFeedModel

@synthesize items;

- (id)initWithRSSFeed:(NSString*)theRSSFeed {
	if (self = [super init]) {
		rssFeed = [theRSSFeed copy];
	}
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(rssFeed);
	TT_RELEASE_SAFELY(items);
	[super dealloc];
}

// Here we send a request to BuildMobile for its RSS feed
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading) {
		
		// We create a new Request for the BuildMobile RSS feed
		// requestDidFinishLoad will be called once the request has ended
		TTURLRequest *request = [TTURLRequest requestWithURL:rssFeed delegate:self];
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = TT_DEFAULT_CACHE_EXPIRATION_AGE;
		
		// This tells the URLRequest to return an XML Document (RSS)
		TTURLXMLResponse* response = [[TTURLXMLResponse alloc] init];
		response.isRssFeed = YES; // Make sure Items are grouped together
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send];
	}
}

// Our Request has finished, time to parse what is stored in our response
- (void)requestDidFinishLoad:(TTURLRequest *)request {
	NSMutableArray *feedItems = [[NSMutableArray alloc] init];
	
	NSLog(@"We had a finish load");
	TTURLXMLResponse *response = (TTURLXMLResponse*) request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	NSDictionary *feed = response.rootObject;
	TTDASSERT([[feed objectForKey:@"channel"] isKindOfClass:[NSDictionary class]]);
	
	NSDictionary *channel = [feed objectForKey:@"channel"];
	NSObject *channelItems = [channel objectForKey:@"item"];
	if ([channelItems isKindOfClass:[NSArray class]]) {
		for (NSDictionary *item in (NSArray*) channelItems) {
			TTDASSERT([[item objectForKey:@"title"] isKindOfClass:[NSDictionary class]]);
			TTDASSERT([[item objectForKey:@"link"] isKindOfClass:[NSDictionary class]]);
			
			// Get the Required Elements from the Dictionary
			NSDictionary *titleElement = [item objectForKey:@"title"];
			NSDictionary *descriptionElement = [item objectForKey:@"description"];
			NSDictionary *linkElement = [item objectForKey:@"link"];
			NSDictionary *pubDate = [item objectForKey:@"pubDate"];
			
			// Format the Recieved String into a Date
			NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
			[dateFormatter setDateFormat:@"EEE, dd MMMM yyyy HH:mm:ss ZZ"];
			NSDate* date = [dateFormatter dateFromString:[pubDate objectForKey:@"___Entity_Value___"]];
			TT_RELEASE_SAFELY(dateFormatter);
			
			// Build the Feed Item
			BMFeedItem *feedItem = [[BMFeedItem alloc] init];
			feedItem.title = [titleElement objectForKey:@"___Entity_Value___"];
			feedItem.description = [descriptionElement objectForKey:@"___Entity_Value___"];
			feedItem.link = [linkElement objectForKey:@"___Entity_Value___"];
			feedItem.publishedDate = date;
			
			[feedItems addObject:feedItem];
			TT_RELEASE_SAFELY(feedItem);
		}
	}
	
	self.items = feedItems;
	TT_RELEASE_SAFELY(feedItems);
	
	[super requestDidFinishLoad:request];	
}

@end
