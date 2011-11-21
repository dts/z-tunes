//
//  ZApplication.m
//  Z-Tunes
//
//  Created by Daniel Staudigel on 12/2/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "ZApplication.h"
#import <Carbon/Carbon.h>

OSStatus hotKeyPressed(EventHandlerCallRef nextHandler,EventRef theEvent,void *userData)
{
 EventHotKeyID hkCom;
 GetEventParameter(theEvent,kEventParamDirectObject,typeEventHotKeyID,NULL,
sizeof(hkCom),NULL,&hkCom);
 [(ZApplication *)[NSApplication sharedApplication] hotKeyPressed];
 return noErr;
}

OSStatus hotKeyReleased(EventHandlerCallRef nextHandler,EventRef theEvent,void *userData)
{
 EventHotKeyID hkCom;
 GetEventParameter(theEvent,kEventParamDirectObject,typeEventHotKeyID,NULL,
sizeof(hkCom),NULL,&hkCom);
 [(ZApplication *)[NSApplication sharedApplication] hotKeyReleased];
 return noErr;
}

@implementation ZApplication

- (void)shutdown:(NSNotification *)note {
	[self terminate:self];
}

- (void)finishLaunching {
	[super finishLaunching];
	
	NSDistributedNotificationCenter * dnc = [NSDistributedNotificationCenter defaultCenter];
	
	[dnc addObserver:self selector:@selector(shutdown:) name:@"ZTunesShutdownInstruction" object:nil];
	
	NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HotKey"];
	
	int key,mods;
	
	if(dict) {
		key = [[dict objectForKey:@"keyCode"] intValue];
		mods = [[dict objectForKey:@"modifiers"] intValue];
	} else {
		key = 49;
		mods = cmdKey;
	}
	
	NSLog(@"Hey! %i %i",key,mods);
	
	EventHotKeyRef gMyHotKeyRef;
	EventHotKeyRef gMyHotKeyRef2;
	EventHotKeyID gMyHotKeyID;
	EventTypeSpec eventType;
	eventType.eventClass=kEventClassKeyboard;
	eventType.eventKind=kEventHotKeyPressed;

	InstallApplicationEventHandler(&hotKeyPressed,1,&eventType,NULL,NULL);

	gMyHotKeyID.signature='htk1';
	gMyHotKeyID.id=1;
	
	RegisterEventHotKey(key, mods, gMyHotKeyID,GetApplicationEventTarget(), 0, &gMyHotKeyRef);
	
	eventType.eventClass=kEventClassKeyboard;
	eventType.eventKind=kEventHotKeyReleased;

	InstallApplicationEventHandler(&hotKeyReleased,1,&eventType,NULL,NULL);

	gMyHotKeyID.signature='htk2';
	gMyHotKeyID.id=2;
	
	RegisterEventHotKey(key, mods, gMyHotKeyID,GetApplicationEventTarget(), 0, &gMyHotKeyRef2);
}

- (void)hotKeyPressed {
	if(currentApplication) { [currentApplication release]; }
	currentApplication = [[[[NSWorkspace sharedWorkspace] activeApplication] objectForKey:@"NSApplicationName"] retain];;
	
	[self activateIgnoringOtherApps:YES];
	[[self delegate] show:self];
}

- (void)hotKeyReleased {
	[[self delegate] hide:self];
	[self deactivate];
	
	if(currentApplication) { [[NSWorkspace sharedWorkspace] launchApplication:currentApplication]; }
}

@end
