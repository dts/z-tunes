#import "ZTunesDaemon.h"
#import "PlayerProxy.h"
#import "iTunesProxy.h"
#import "SpotifyProxy.h"

@implementation ZTunesDaemon

- (PlayerProxy *)proxy {
	if(!currentProxy.running) {
		PlayerProxy * iTunes = [iTunesProxy sharedProxy];
		PlayerProxy * Spotify = [SpotifyProxy sharedProxy];
		
		if(!iTunes.running && !Spotify.running)
			// Neither is running
			return currentProxy = iTunes;
		if(iTunes.running && !Spotify.running)
			// iTunes is running
			return currentProxy = iTunes;
		if(!iTunes.running && Spotify.running)
			// Spotify is running
			return currentProxy = Spotify;
		
		// Both are running!
		
		if(iTunes.playing && !Spotify.playing)
			// iTunes is playing, spotify is not
			return currentProxy = iTunes;
		if(!iTunes.playing && Spotify.playing)
			// Spotify is playing, iTUnes is not
			return currentProxy = Spotify;
		
		// Both are playing!
		
		[iTunes stop];
		[Spotify stop];
		
		return currentProxy = iTunes;
	}
	
	return currentProxy;
}

- (IBAction)fastForward:(id)sender {
    [self.proxy fastForward];
}

- (IBAction)playpause:(id)sender {
	[self.proxy playpause];
}

- (IBAction)rewind:(id)sender {
	[self.proxy rewind];
}

- (IBAction)skipBackward:(id)sender {
    [self.proxy prevTrack];
	[self refresh];
}

- (IBAction)skipForward:(id)sender {
    [self.proxy nextTrack];
	[self refresh];
}

- (IBAction)setRating:(id)sender {
	[self.proxy setCurrentTrackRating:[i_rating intValue]];
	[self refresh];
}

- (IBAction)hide:(id)sender {
	[i_window orderOut:sender];
}

- (IBAction)show:(id)sender {
	[i_window makeKeyAndOrderFront:sender];
}

- (IBAction)volumeUp:(id)sender {
	[self.proxy setVolume:[i_volume intValue]+10];
	[self refresh];
}

- (IBAction)volumeDown:(id)sender {
	[self.proxy setVolume:[i_volume intValue]-10];
	[self refresh];
}

- (void)refresh {
	if(![self.proxy running]) return;
	NSString * track = [self.proxy currentTrackName];
	NSString * album = [self.proxy currentTrackAlbum];
	NSString * artist = [self.proxy currentTrackArtist];
	[i_title setStringValue:track?track:@""];
	[i_artist setStringValue:artist?[NSString stringWithFormat:@"by: %@",artist]:@""];
	[i_album setStringValue:album?[NSString stringWithFormat:@"on: %@",album]:@""];
	[i_rating setIntValue:[self.proxy currentTrackRating]];
	[i_volume setStringValue:[NSString stringWithFormat:@"%i%%",[self.proxy volume]]];
}

- (void)windowDidBecomeKey:(NSNotification *)note {
	NSLog(@"windowDidBecomeMain: %@",[self.proxy currentTrackAlbum]);
	
	[self refresh];
}

- (void)keyDown:(NSEvent *)e {
	NSLog(@"KeyDown: %@",[e description]);
	int rating = [[e charactersIgnoringModifiers] intValue];
	
	if([e keyCode] == 124) {
		[self.proxy nextTrack];
	}
	else if([e keyCode] == 123) {
		[self.proxy prevTrack];
	}
	else if([e keyCode] == 36) {
		[self.proxy playpause];
	}
	else if([e keyCode] == 126) {
		[self volumeUp:self];
	}
	else if([e keyCode] == 125) {
		[self volumeDown:self];
	}
	else if([e keyCode] == 14) {
		[self.proxy quit];
	}
	else if(rating >= 0 && rating <= 5) {
		[self.proxy setCurrentTrackRating:rating];
	} 
	
	[self refresh];
}

- (void)keyUp:(NSEvent *)e {
	
}

@end
