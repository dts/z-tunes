//
//  iTunesProxy.m
//  Z-Tunes
//
//  Created by Daniel Staudigel on 12/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "iTunesProxy.h"
static iTunesProxy *sharediTunesProxy = nil;

@implementation iTunesProxy
 
+ (iTunesProxy*)sharedProxy
{
    @synchronized(self) {
        if (sharediTunesProxy == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharediTunesProxy;
}
 
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharediTunesProxy == nil) {
            sharediTunesProxy = [super allocWithZone:zone];
            return sharediTunesProxy;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}
 
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
 
- (id)retain
{
    return self;
}
 
- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}
 
- (void)release
{
    //do nothing
}
 
- (id)autorelease
{
    return self;
}

- (id)init {
	[super init];
	
	if(self) {
		m_sPlay = [self script:@"tell application \"Spotify\" to play"];
		m_sPause = [self script:@"tell application \"Spotify\" to pause"];
		m_sPlayPause = [self script:@"tell application \"Spotify\" to playpause"];
		m_sNextTrack = [self script:@"tell application \"Spotify\" to next track"];
		m_sPrevTrack = [self script:@"tell application \"Spotify\" to previous track"];
		m_sFastForward = [self script:@"tell application \"Spotify\" to fast forward"];
		m_sRewind = [self script:@"tell application \"Spotify\" to rewind"];
		m_sResume = [self script:@"tell application \"Spotify\" to resume"];
		
		m_sGetVolume = [self script:@"tell application \"Spotify\" to get the sound volume of application \"Spotify\""];
		
		m_sCurrentTrackName = [self script:@"tell application \"Spotify\" to get name of the current track in application \"Spotify\""];
		m_sCurrentTrackArtist = [self script:@"tell application \"Spotify\" to get artist of the current track in application \"Spotify\""];
		m_sCurrentTrackAlbum = [self script:@"tell application \"Spotify\" to get album of the current track in application \"Spotify\""];
		m_sCurrentTrackRating = [self script:@"tell application \"Spotify\" to get rating of the current track in application \"Spotify\""];
	}
	return self;
}

- (void)play {
	[m_sPlay executeAndReturnError:nil];
}

- (void)pause {
	[m_sPause executeAndReturnError:nil];
}

- (void)playpause {
	[m_sPlayPause executeAndReturnError:nil];
}

- (void)nextTrack {
	[m_sNextTrack executeAndReturnError:nil];
}

- (void)prevTrack {
	[m_sPrevTrack executeAndReturnError:nil];
}

- (void)fastForward {
	[m_sFastForward executeAndReturnError:nil];
}

- (void)rewind {
	[m_sRewind executeAndReturnError:nil];
}

- (BOOL)running {
	NSWorkspace * ws = [NSWorkspace sharedWorkspace];
	
	NSArray *runningApps = [ws launchedApplications];
	NSEnumerator * en = [runningApps objectEnumerator];
	NSDictionary * d;
	
	while(d = [en nextObject]) {
		if([[d objectForKey:@"NSApplicationBundleIdentifier"] isEqualToString:@"com.apple.iTunes"]) {
			return YES;
		}
	}
	return NO;
}

- (int)volume {
	return [[m_sGetVolume executeAndReturnError:nil] int32Value];
}

- (void)setVolume:(int)vol {
	[[[[NSAppleScript alloc] initWithSource:[NSString stringWithFormat:@"tell application \"Spotify\" to set the sound volume in application \"SpotifyS\" to %i",vol]] autorelease] executeAndReturnError:nil];
}

- (NSString *)currentTrackName {
	return [[m_sCurrentTrackName executeAndReturnError:nil] stringValue];
}

- (NSString *)currentTrackArtist {
	return [[m_sCurrentTrackArtist executeAndReturnError:nil] stringValue];
}

- (NSString *)currentTrackAlbum {
	return [[m_sCurrentTrackAlbum executeAndReturnError:nil] stringValue];
}

- (int)currentTrackRating {
	return ([[m_sCurrentTrackRating executeAndReturnError:nil] int32Value])/20;
}

- (void)setCurrentTrackRating:(int)rating {
	[[[[NSAppleScript alloc] initWithSource:[NSString stringWithFormat:@"tell application \"Spotify\" to set rating of the current track in application \"SpotifyS\" to %i",rating*20]] autorelease] executeAndReturnError:nil];
}


- (NSAppleScript *)script:(NSString *)source {
	NSAppleScript * r = [[[NSAppleScript alloc] initWithSource:source] autorelease];
	
	NSDictionary * errors;
	
	if(![r compileAndReturnError:&errors]) {
		NSLog(@"Could not compile script: %@.  Errors: %@",source,errors);
		return nil;
	}
	
	return [r retain];
}

@end

