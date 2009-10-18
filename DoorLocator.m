//
//  DoorLocator.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DoorLocator.h"

@implementation DoorLocator

+ (id)newWithHorizontalDoor:(BOOL)aHorizontalDoor x:(int)x y:(int)y 
{
    return [[DoorLocator alloc] initWithHorizontalDoor:aHorizontalDoor x:x y:y];
}

- (id)initWithHorizontalDoor:(BOOL)aHorizontalDoor x:(int)x y:(int)y
{
    if (self = [super init]) {
        horizontalDoor = aHorizontalDoor;
        coordinates.x = x;
        coordinates.y = y;
    }
    return self;
}

@synthesize horizontalDoor;
@synthesize coordinates;

- (int)x
{
    return coordinates.x;
}

- (int)y
{
    return coordinates.y;
}

@end
