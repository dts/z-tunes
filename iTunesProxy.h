//
//  iTunesProxy.h
//  Z-Tunes
//
//  Created by Daniel Staudigel on 12/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface iTunesProxy : NSObject {
	NSAppleScript * m_sPlay;
	NSAppleScript * m_sPause;
	NSAppleScript * m_sPlayPause;
	NSAppleScript * m_sNextTrack;
	NSAppleScript * m_sPrevTrack;
	NSAppleScript * m_sFastForward;
	NSAppleScript * m_sRewind;
	NSAppleScript * m_sResume;
	NSAppleScript * m_sCurrentTrackName;
	NSAppleScript * m_sCurrentTrackArtist;
	NSAppleScript * m_sCurrentTrackAlbum;
	NSAppleScript * m_sCurrentTrackRating;
	NSAppleScript * m_sGetVolume;
	
}
+ (iTunesProxy *)sharedProxy;

- (void)play;
- (void)pause;
- (void)playpause;
- (void)nextTrack;
- (void)prevTrack;
- (void)fastForward;
- (void)rewind;

- (BOOL)running;

- (int)volume;
- (void)setVolume:(int)vol;

- (NSString *)currentTrackName;
- (NSString *)currentTrackArtist;
- (NSString *)currentTrackAlbum;
- (int)currentTrackRating;
- (void)setCurrentTrackRating:(int)rating;

- (NSAppleScript *)script:(NSString *)source;

@end
