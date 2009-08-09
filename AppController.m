//
//  AppController.m
//  Doors
//
//  Created by Axel Großmann, Mathias Kegelmann on 8/9/09.
//  All rights reserved.
//

#import "AppController.h"


@implementation AppController
-(id)init
{
	if(![super init]) return nil;
	doorsClosed = NO;
	return self;
}

@synthesize doorsClosed;

- (IBAction)start:(id)sender
{
	NSLog(@"Start clicked.");
	[self willChangeValueForKey:@"doorsClosed"];
	doorsClosed = YES;
	[self didChangeValueForKey:@"doorsClosed"];
	[view setNeedsDisplay:NO]; // remove me
}

- (IBAction)reset:(id)sender
{
	NSLog(@"Reset clicked.");
	[self willChangeValueForKey:@"doorsClosed"];
	doorsClosed = NO;
	[self didChangeValueForKey:@"doorsClosed"];
	[view setNeedsDisplay:NO]; // remove me
}

@end
