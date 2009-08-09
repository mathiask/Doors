//
//  AppController.h
//  Doors
//
//  Created by Axel Großmann, Mathias Kegelmann on 8/9/09.
//  All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppController : NSObject {
	BOOL doorsClosed;
	IBOutlet id view; // remove me when KVO works!
}
@property(readonly) BOOL doorsClosed;

- (IBAction)start:(id)sender;
- (IBAction)reset:(id)sender;

@end
