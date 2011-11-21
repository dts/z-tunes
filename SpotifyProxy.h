//
//  SpotifyProxy.h
//  Z-Tunes
//
//  Created by Daniel Staudigel on 11/21/11.
//  Copyright (c) 2011 mountainmandan.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PlayerProxy.h"
#import "SingletonHelper.h"
#import "Spotify.h"

@interface SpotifyProxy : PlayerProxy
@property (readonly) SpotifyApplication * Spotify;
+ (SpotifyProxy*)sharedProxy;
@end
