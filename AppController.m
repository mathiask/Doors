//
//  AppController.m
//  Doors
//
//  Created by Axel Großmann, Mathias Kegelmann on 8/9/09.
//  All rights reserved.
//

#import "AppController.h"


@implementation AppController
- (id)init
{
	if(self = [super init]) {
        doorsClosed = NO;
    }
    return self;
}

@synthesize doorsClosed;

- (IBAction)start:(id)sender
{
	NSLog(@"Start clicked.");
	[self setDoorsClosed: YES];
}

- (IBAction)reset:(id)sender
{
	NSLog(@"Reset clicked.");
	[self setDoorsClosed:NO];
}

@end
