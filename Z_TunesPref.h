//
//  Z_TunesPref.h
//  Z-Tunes
//
//  Created by Daniel Staudigel on 12/2/07.
//  Copyright (c) 2007 __MyCompanyName__. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>
#import "PTKeyCombo.h"

@interface Z_TunesPref : NSPreferencePane 
{
	IBOutlet NSButton * i_setHotKeyButton;
	IBOutlet NSButton * i_enabledButton;
	PTKeyCombo *			mKeyCombo;
}

- (void) mainViewDidLoad;
- (PTKeyCombo *)storedKeyCombo;
- (void)setStoredKeyCombo:(PTKeyCombo *)hk;
- (BOOL)isLoginItem;
- (void)setIsLoginItem:(BOOL)tf;
- (void)setIsRunning:(BOOL)tf;
- (void)refresh;
- (IBAction)resetHotKey:(id)sender;
- (IBAction)enabledChanged:(id)sender;
@end
