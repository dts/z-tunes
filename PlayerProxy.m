//
//  PlayerProxy.m
//  Z-Tunes
//
//  Created by Daniel Staudigel on 11/21/11.
//  Copyright (c) 2011 mountainmandan.net. All rights reserved.
//

#import "PlayerProxy.h"

@implementation PlayerProxy
@synthesize app;
- (void)quit {
	[self.app quit];
}
@end
