//
//  BMFeedListController.m
//  BuildMobileThree20
//
//  Created by Ben Morrall on 18/05/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "BMFeedListController.h"

#import "BMFeedDataSource.h"

@implementation BMFeedListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"BuildMobile RSS";
		self.variableHeightRows = YES;
	}
	return self;
}

// Returns a BMFeedDataSource which will create a Model and define our Table View
- (void)createModel {
	self.dataSource = [[[BMFeedDataSource alloc] initWithRSSFeed:@"http://buildmobile.com/feed/"] autorelease];
}

// Adds Pull to Reload to our table,  sweet!
- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
