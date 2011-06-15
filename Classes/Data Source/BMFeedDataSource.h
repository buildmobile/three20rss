//
//  BMFeedDataSource.h
//  BuildMobileThree20
//
//  Created by Ben Morrall on 18/05/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Three20/Three20.h>

#import "BMFeedModel.h"

@interface BMFeedDataSource : TTListDataSource {
	BMFeedModel *feedModel;
}

- (id)initWithRSSFeed:(NSString*)rssFeed;

@end
