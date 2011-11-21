//
//  PlayerProxy.h
//  Z-Tunes
//
//  Created by Daniel Staudigel on 11/21/11.
//  Copyright (c) 2011 mountainmandan.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ScriptingBridge/ScriptingBridge.h>

@interface PlayerProxy : NSObject {
	SBApplication * app;
}
@property (retain) SBApplication * app;
- (void)play;
- (void)pause;
- (void)playpause;
- (void)nextTrack;
- (void)prevTrack;
- (void)fastForward;
- (void)rewind;

- (BOOL)playing;
- (BOOL)running;
- (void)stop;

- (int)volume;
- (void)setVolume:(int)vol;
- (void)quit;

- (NSString *)currentTrackName;
- (NSString *)currentTrackArtist;
- (NSString *)currentTrackAlbum;
- (int)currentTrackRating;
- (void)setCurrentTrackRating:(int)rating;
@end
