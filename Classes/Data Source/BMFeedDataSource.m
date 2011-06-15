//
//  BMFeedDataSource.m
//  BuildMobileThree20
//
//  Created by Ben Morrall on 18/05/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "BMFeedDataSource.h"

#import "BMFeedItem.h"

#import <Three20Core/NSDateAdditions.h>
#import <Three20Core/NSStringAdditions.h>

@implementation BMFeedDataSource

- (id)initWithRSSFeed:(NSString*)rssFeed {
	if (self = [super init]) {
		feedModel = [[BMFeedModel alloc] initWithRSSFeed:rssFeed];
	}
	return self;
}

// Give the model to our TableView to chew on
- (id<TTModel>)model {
	return feedModel;
}
   
// Our Model has loaded items, make it work
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray *items = [[NSMutableArray alloc] init];
	
	// Convert Feed Items into TableCells
	for (BMFeedItem *feedItem in feedModel.items) {
		// Get the Heading, make it safe
		NSString *headingString = [feedItem.title stringByRemovingHTMLTags];
		NSString *descriptionString = [feedItem.description stringByRemovingHTMLTags];
		NSString *publishedString = [feedItem.publishedDate formatRelativeTime];
		
		NSString *content = [NSString stringWithFormat:@"<b>%@</b>\n%@\n<i>%@</i>",
							 headingString,
							 descriptionString,
							 publishedString];
		
		
		TTStyledText* styledText = [TTStyledText textFromXHTML:content lineBreaks:YES URLs:YES];
		[items addObject:[TTTableStyledTextItem itemWithText:styledText URL:feedItem.link]];
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return NSLocalizedString(@"Updating BuildMobile feed...", @"RSS feed updating text");
	} else {
		return NSLocalizedString(@"Loading BuildMobile feed...", @"RSS feed loading text");
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
	return NSLocalizedString(@"No stories found.", @"RSS Feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
	return NSLocalizedString(@"Sorry, there was an error loading the BuildMobile RSS Feed.", @"");
}


- (void)dealloc {
	TT_RELEASE_SAFELY(feedModel);
	[super dealloc];
}

@end
