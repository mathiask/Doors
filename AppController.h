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
}
@property BOOL doorsClosed;

- (IBAction)start:(id)sender;
- (IBAction)reset:(id)sender;

@end
