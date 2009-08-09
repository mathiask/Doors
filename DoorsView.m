//
//  DoorsView.m
//  Doors
//
//  Created by Mathias Kegelmann on 8/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DoorsView.h"

@implementation DoorsView

-(id)initWithFrame:(NSRect)rect
{
	if(![super initWithFrame:rect]) return nil;
	NSLog(@"Registering observer");
	[appController addObserver:self forKeyPath:@"doorsClosed" options:NSKeyValueObservingOptionOld context:nil];
	return self;
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSLog(@"Observed change");
	[self setNeedsDisplay:NO];
}


-(int)hingeSize
{
	return 20;
}


-(void)drawBackground:(NSRect)bounds
{
	[[NSColor greenColor] set];
	[NSBezierPath fillRect:bounds];
}


-(void)drawHinges:(NSRect)bounds
{
	int boardSize = (int)bounds.size.width / 3; // assuming width = height for now
	NSRect circleBounds;
	circleBounds.size.width = [self hingeSize];
	circleBounds.size.height = [self hingeSize];
	
	[[NSColor blackColor] set];
	for (int x = 1; x <= 2; x++) {
		for (int y = 1; y <= 2; y++) {
			circleBounds.origin.x = x * boardSize - [self hingeSize] / 2;
			circleBounds.origin.y = y * boardSize - [self hingeSize] / 2;
			[[NSBezierPath bezierPathWithOvalInRect:circleBounds] fill];
		}
	}
	
}

-(void)drawDoors:(NSRect)bounds
{
	if (![appController doorsClosed]) return;
	
	[[NSColor blueColor] set];
	NSBezierPath *path = [NSBezierPath bezierPath];
	[path setLineWidth:3.0];
	NSPoint point;
	point.x = point.y = 160;
	[path moveToPoint:point];
	point.x = 290;
	[path lineToPoint:point];
	[path closePath];
	[path stroke];
}

- (void)drawRect:(NSRect)rect 
{
	NSRect bounds = [self bounds];
	[self drawBackground:bounds];
	[self drawHinges:bounds];
	[self drawDoors:bounds];
}

@end
