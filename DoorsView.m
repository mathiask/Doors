//
//  DoorsView.m
//  Doors
//
//  Created by Mathias Kegelmann on 8/9/09.
//  Copyright 2009. All rights reserved.
//

#import "DoorsView.h"

@implementation DoorsView

- (void)awakeFromNib
{
	NSLog(@"Registering observer having just woken up from NIB...");
	[appController addObserver:self forKeyPath:@"doorsClosed" options:NSKeyValueObservingOptionOld context:nil];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSLog(@"Observed change, setting dirty flag");
	[self setNeedsDisplay:YES];
}


- (int)hingeSize
{
	return 20;
}


- (void)drawBackground:(NSRect)bounds
{
	[[NSColor greenColor] set];
	[NSBezierPath fillRect:bounds];
}


- (void)drawHinges:(NSRect)bounds
{
	int boardSize = (int)bounds.size.width / 3; // assuming width = height for now
	NSRect circleBounds = {{0, 0}, {[self hingeSize], [self hingeSize]}};	
	[[NSColor blackColor] set];
	for (int x = 1; x <= 2; x++) {
		for (int y = 1; y <= 2; y++) {
			circleBounds.origin.x = x * boardSize - [self hingeSize] / 2;
			circleBounds.origin.y = y * boardSize - [self hingeSize] / 2;
			[[NSBezierPath bezierPathWithOvalInRect:circleBounds] fill];
		}
	}
}

- (void)drawDoors:(NSRect)bounds
{
	if (![appController doorsClosed]) return;
	
	[[NSColor blueColor] set];
	NSBezierPath *path = [NSBezierPath bezierPath];
	[path setLineWidth:3.0];
	NSPoint point = {160, 160};
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
