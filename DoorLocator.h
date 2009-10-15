//
//  DoorLocator.h
//  Doors
//
//  Created by Mathias Kegelmann on 10/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DoorsDirections.h"

#define HORIZONTAL_DOOR YES
#define VERTICAL_DOOR NO

@interface DoorLocator : NSObject {
    BOOL horizontalDoor;
    DoorsDoorCoordinates coordinates;
}

+ (id)newWithHorizontalDoor:(BOOL)aHorizontalDoor x:(int)x y:(int)z;
- (id)initWithHorizontalDoor:(BOOL)aHorizontalDoor x:(int)x y:(int)y;

@property(readonly) BOOL horizontalDoor;
@property(readonly) DoorsDoorCoordinates coordinates;
@property(readonly) int x;
@property(readonly) int y;

@end
