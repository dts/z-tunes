//
//  SpotifyProxy.m
//  Z-Tunes
//
//  Created by Daniel Staudigel on 11/21/11.
//  Copyright (c) 2011 mountainmandan.net. All rights reserved.
//

#import "SpotifyProxy.h"
#import "SingletonHelper.h"

@implementation SpotifyProxy
SINGLETON_IMPS(SpotifyProxy,sharedProxy)

- (id)init {
	[super init];
	
	if(self) {
		self.app = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
	}
	
	return self;
}

- (SpotifyApplication *)Spotify {
	return (SpotifyApplication *)self.app;
}

- (void)stop {
	[self.Spotify pause];
}

- (void)playpause {
	[self.Spotify playpause];
}

- (void)nextTrack {
	[self.Spotify nextTrack];
}

- (void)prevTrack {
	[self.Spotify previousTrack];
}

- (void)fastForward {
// no equivalent
}
- (void)rewind {
// no equivalent
}

- (BOOL)playing {
	return [self.Spotify playerState] == SpotifyEPlSPlaying;
}

- (BOOL)running {
	return [self.Spotify isRunning];
}

- (int)volume {
	return [self.Spotify soundVolume];
}
- (void)setVolume:(int)vol {
	self.Spotify.soundVolume = vol;
}

- (NSString *)currentTrackName {
	return self.Spotify.currentTrack.name;
}

- (NSString *)currentTrackArtist {
	return self.Spotify.currentTrack.artist;
}
- (NSString *)currentTrackAlbum {
	return self.Spotify.currentTrack.album;
}
- (int)currentTrackRating {
	return self.Spotify.currentTrack.starred?3:0;
}
- (void)setCurrentTrackRating:(int)rating {
// 	self.Spotify.currentTrack.starred = (rating >= 3);
}

@end
