//
//  ZApplication.h
//  Z-Tunes
//
//  Created by Daniel Staudigel on 12/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>hello


@interface ZApplication : NSApplication {
	NSString * currentApplication;
}

- (void)hotKeyPressed;
- (void)hotKeyReleased;

@end
