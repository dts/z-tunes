#import "ZTunesWindow.h"

@implementation ZTunesWindow

- (void)keyDown:(NSEvent *)e {
	[[self delegate] keyDown:e];
}

- (void)keyUp:(NSEvent *)e {
	[[self delegate] keyUp:e];
}

@end
