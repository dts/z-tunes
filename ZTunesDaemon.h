#import <Cocoa/Cocoa.h>
#import "PlayerProxy.h"

@interface ZTunesDaemon : NSObject {
    IBOutlet NSTextField *i_album;
    IBOutlet NSTextField *i_artist;
    IBOutlet NSTextField *i_lastPlayed;
    IBOutlet NSLevelIndicator *i_rating;
    IBOutlet NSTextField *i_title;
    IBOutlet NSWindow *i_window;
	IBOutlet NSTextField *i_volume;
	
	PlayerProxy * currentProxy;
}
@property (readonly) PlayerProxy * proxy;
- (IBAction)fastForward:(id)sender;
- (IBAction)playpause:(id)sender;
- (IBAction)rewind:(id)sender;
- (IBAction)skipBackward:(id)sender;
- (IBAction)skipForward:(id)sender;
- (IBAction)setRating:(id)sender;
- (IBAction)show:(id)sender;
- (IBAction)hide:(id)sender;
- (IBAction)volumeUp:(id)sender;
- (IBAction)volumeDown:(id)sender;
- (void)refresh;
- (void)keyDown:(NSEvent *)e;
- (void)keyUp:(NSEvent *)e;
@end
