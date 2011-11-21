//
//  iTunesProxy.h
//  Z-Tunes
//
//  Created by Daniel Staudigel on 12/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PlayerProxy.h"
#import "SingletonHelper.h"
#import "iTunes.h"

@interface iTunesProxy : PlayerProxy {
}
@property (readonly) iTunesApplication * iTunes;
+ (iTunesProxy*)sharedProxy;
@end
