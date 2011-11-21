#import "ZTunesDaemon.h"

@implementation ZTunesDaemon
- (void)awakeFromNib {
	m_proxy = [iTunesProxy sharedProxy];
}

- (IBAction)fastForward:(id)sender {
    [m_proxy fastForward];
}

- (IBAction)playpause:(id)sender {
	[m_proxy playpause];
}

- (IBAction)rewind:(id)sender {
	[m_proxy rewind];
}

- (IBAction)skipBackward:(id)sender {
    [m_proxy prevTrack];
	[self refresh];
}

- (IBAction)skipForward:(id)sender {
    [m_proxy nextTrack];
	[self refresh];
}

- (IBAction)setRating:(id)sender {
	[m_proxy setCurrentTrackRating:[i_rating intValue]];
	[self refresh];
}

- (IBAction)hide:(id)sender {
	[i_window orderOut:sender];
}

- (IBAction)show:(id)sender {
	[i_window makeKeyAndOrderFront:sender];
}

- (IBAction)volumeUp:(id)sender {
	[m_proxy setVolume:[i_volume intValue]+10];
	[self refresh];
}

- (IBAction)volumeDown:(id)sender {
	[m_proxy setVolume:[i_volume intValue]-10];
	[self refresh];
}

- (void)refresh {
	if(![m_proxy running]) return;
	NSString * track = [m_proxy currentTrackName];
	NSString * album = [m_proxy currentTrackAlbum];
	NSString * artist = [m_proxy currentTrackArtist];
	[i_title setStringValue:track?track:@""];
	[i_artist setStringValue:artist?[NSString stringWithFormat:@"by: %@",artist]:@""];
	[i_album setStringValue:album?[NSString stringWithFormat:@"on: %@",album]:@""];
	[i_rating setIntValue:[m_proxy currentTrackRating]];
	[i_volume setStringValue:[NSString stringWithFormat:@"%i%%",[m_proxy volume]]];
}

- (void)windowDidBecomeKey:(NSNotification *)note {
	NSLog(@"windowDidBecomeMain: %@",[m_proxy currentTrackAlbum]);
	
	[self refresh];
}

- (void)keyDown:(NSEvent *)e {
	NSLog(@"KeyDown: %@",[e description]);
	int rating = [[e charactersIgnoringModifiers] intValue];
	
	if([e keyCode] == 124) {
		[m_proxy nextTrack];
	}
	else if([e keyCode] == 123) {
		[m_proxy prevTrack];
	}
	else if([e keyCode] == 36) {
		[m_proxy playpause];
	}
	else if([e keyCode] == 126) {
		[self volumeUp:self];
	}
	else if([e keyCode] == 125) {
		[self volumeDown:self];
	}
	else if(rating >= 0 && rating <= 5) {
		[m_proxy setCurrentTrackRating:rating];
	}
	
	[self refresh];
}

- (void)keyUp:(NSEvent *)e {
	
}

@end
