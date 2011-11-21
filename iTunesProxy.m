//
//  iTunesProxy.m
//  Z-Tunes
//
//  Created by Daniel Staudigel on 12/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "iTunesProxy.h"
#import "SingletonHelper.h"

static iTunesProxy *sharediTunesProxy = nil;

@implementation iTunesProxy
 
SINGLETON_IMPS(iTunesProxy,sharedProxy)

- (id)init {
	[super init];
	
	if(self) {
		self.app = [SBApplication applicationWithBundleIdentifier:@"com.apple.itunes"];
	}
	
	return self;
}

- (iTunesApplication *)iTunes {
	return (iTunesApplication *)self.app;
}

- (void)playpause {
	[self.iTunes playpause];
}

- (void)stop {
	[self.iTunes stop];
}

- (void)nextTrack {
	[self.iTunes nextTrack];
}

- (void)prevTrack {
	[self.iTunes previousTrack];
}

- (void)fastForward {
	[self.iTunes fastForward];
}
- (void)rewind {
	[self.iTunes rewind];
}

- (BOOL)playing {
	return [self.iTunes playerState] == iTunesEPlSPlaying;
}



- (BOOL)running {
	return [self.iTunes isRunning];
}

- (int)volume {
	return [self.iTunes soundVolume];
}
- (void)setVolume:(int)vol {
	self.iTunes.soundVolume = vol;
}

- (NSString *)currentTrackName {
	return self.iTunes.currentTrack.name;
}

- (NSString *)currentTrackArtist {
	return self.iTunes.currentTrack.artist;
}
- (NSString *)currentTrackAlbum {
	return self.iTunes.currentTrack.album;
}
- (int)currentTrackRating {
	return self.iTunes.currentTrack.rating;
}
- (void)setCurrentTrackRating:(int)rating {
	self.iTunes.currentTrack.rating = rating;
}

@end

