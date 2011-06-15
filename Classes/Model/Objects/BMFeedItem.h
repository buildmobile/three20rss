//
//  BMFeedItem.h
//  BuildMobileThree20
//
//  Created by Ben Morrall on 18/05/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BMFeedItem : NSObject {
	NSString *title;
	NSString *description;
	NSDate *publishedDate;
	NSString *link;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, retain) NSDate *publishedDate;

@end
