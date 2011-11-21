//
//  Z_TunesPref.m
//  Z-Tunes
//
//  Created by Daniel Staudigel on 12/2/07.
//  Copyright (c) 2007 __MyCompanyName__. All rights reserved.
//

#import "Z_TunesPref.h"
#import "PTKeyComboPanel.h"


@implementation Z_TunesPref

- (void)mainViewDidLoad {
	mKeyCombo = [[self storedKeyCombo] retain];
	[self refresh];
}

- (void) willSelect {
	[self refresh];
}

- (void)didUnselect {
	[self setIsRunning:[self isLoginItem]];
}

- (PTKeyCombo *)storedKeyCombo {
	NSDictionary * prefs = [NSDictionary dictionaryWithContentsOfFile:[@"~/Library/Preferences/net.mountainmandan.Z-TunesDaemon.plist" stringByExpandingTildeInPath]];
	PTKeyCombo * combo = [PTKeyCombo alloc];
	
	id plistRep = [prefs objectForKey:@"HotKey"];
	if(plistRep) {
		[combo initWithPlistRepresentation:plistRep];
	} else {
		[combo initWithKeyCode:49 modifiers:NSCommandKeyMask];
	}
	
	[combo autorelease];
	return combo;
}

- (void)setStoredKeyCombo:(PTKeyCombo *)hk {
	NSMutableDictionary * prefs = [NSMutableDictionary dictionaryWithContentsOfFile:[@"~/Library/Preferences/net.mountainmandan.Z-TunesDaemon.plist" stringByExpandingTildeInPath]];
	if(!prefs) { prefs = [NSMutableDictionary dictionaryWithCapacity:1]; }
	NSLog(@"Saving: %@",[prefs description]);
	[prefs setObject:[mKeyCombo plistRepresentation] forKey:@"HotKey"];
	[prefs writeToFile:[@"~/Library/Preferences/net.mountainmandan.Z-TunesDaemon.plist" stringByExpandingTildeInPath] atomically:YES];
}

- (BOOL)isLoginItem {
	NSDictionary * read = [NSDictionary dictionaryWithContentsOfFile:[@"~/Library/Preferences/loginwindow.plist" stringByExpandingTildeInPath]];
	NSArray * list = [read objectForKey:@"AutoLaunchedApplicationDictionary"];
	NSEnumerator * en = [list objectEnumerator];
	NSDictionary * d;
	
	while(d = [en nextObject]) {
		if([[d objectForKey:@"Path"] rangeOfString:@"Z-TunesDaemon.app"].location != NSNotFound) {
			return YES;
		} 
	}
	
	return NO;
}

- (void)setIsLoginItem:(BOOL)tf {
	if(tf == [self isLoginItem]) { return; }
	
	NSMutableDictionary * dict = [[NSDictionary dictionaryWithContentsOfFile:[@"~/Library/Preferences/loginwindow.plist" stringByExpandingTildeInPath]] mutableCopy];
	NSMutableArray * arr = [[dict objectForKey:@"AutoLaunchedApplicationDictionary"] mutableCopy];
	
	
	if(tf) {
		NSMutableDictionary * addition = [NSMutableDictionary dictionaryWithCapacity:2];
		[addition setObject:[NSNumber numberWithBool:NO] forKey:@"Hide"];
		[addition setObject:[[NSBundle bundleForClass:[self class]] pathForResource:@"Z-TunesDaemon" ofType:@"app"] forKey:@"Path"];
		[arr addObject:addition];
	} else {
		int i;
		for(i = 0 ; i < [arr count] ; i++) {
			NSDictionary * d = [arr objectAtIndex:i];
			if([[d objectForKey:@"Path"] rangeOfString:@"Z-TunesDaemon.app"].location != NSNotFound) {
				[arr removeObjectAtIndex:i];
			} 
		}
	}
	
	[dict setObject:arr forKey:@"AutoLaunchedApplicationDictionary"];
	
	[dict writeToFile:[@"~/Library/Preferences/loginwindow.plist" stringByExpandingTildeInPath] atomically:YES];
}

- (void)setIsRunning:(BOOL)tf {
	NSWorkspace * ws = [NSWorkspace sharedWorkspace];
	NSLog(@"SetIsRunning: %i",tf);
	
	if(tf) {
		NSLog(@"Launching...");
		[ws openFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"Z-TunesDaemon" ofType:@"app"]];
	} else {
		NSLog(@"Shutting DOwn\n");
		[[NSDistributedNotificationCenter defaultCenter]
			postNotificationName:@"ZTunesShutdownInstruction" object:@""];
	}
}

- (void)refresh {
	[i_enabledButton setState:[self isLoginItem]];
	
	if(mKeyCombo) {
		[i_setHotKeyButton setTitle:[mKeyCombo description]];
	} else {
		[i_setHotKeyButton setTitle:@"Set"];
	}
}

- (void)hotKeySheetDidEndWithReturnCode: (NSNumber*)resultCode
{
	if( [resultCode intValue] == NSOKButton )
	{
		//Update our hotkey with the new keycombo
		if(mKeyCombo) { [mKeyCombo release]; }
		mKeyCombo = [[PTKeyComboPanel sharedPanel] keyCombo];
		if(mKeyCombo) { [mKeyCombo retain]; }
		
		[self setStoredKeyCombo:mKeyCombo];
		//Update our window
		[self refresh];
	}
	
	[self setIsRunning:[self isLoginItem]];
}

- (IBAction)resetHotKey:(id)sender {
	[self setIsRunning:0];
	PTKeyComboPanel* panel = [PTKeyComboPanel sharedPanel];
	[panel setKeyCombo: mKeyCombo];
	[panel setKeyBindingName: @"Z-Tunes"];
	[panel runSheeetForModalWindow: [[self mainView] window] target: self];
}

- (IBAction)enabledChanged:(id)sender {
	[self setIsRunning:[sender state]];
	[self setIsLoginItem:[sender state]];
	
	[self refresh];
}

@end
