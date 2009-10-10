//
//  WorldModel.h
//  Doors
//
//  Created by Mathias Kegelmann on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DoorsDirections.h"

// Auxiliary type to specify a horizontal or vertical door, plus coordinates
typedef struct {
    BOOL horizontalDoor;
    DoorsDoorCoordinates coordinates;
} DoorLocator;

#define HORIZONTAL_DOOR YES
#define VERTICAL_DOOR NO

@interface WorldModel : NSObject {
    BOOL horizontalDoorsOpen[3][2];
    BOOL verticalDoorsOpen[2][3];
}

// invalid (x,y) implies false
- (BOOL)isHorizontalDoorOpenAtX:(int)x andY:(int)y;
- (BOOL)isHorizontalDoorOpen:(DoorsDoorCoordinates)doorCoordinates;
- (BOOL)isVerticalDoorOpenAtX:(int)x andY:(int)y;
- (BOOL)isVerticalDoorOpen:(DoorsDoorCoordinates)doorCoordinates;

- (void)closeHorizontalDoorAtX:(int)x andY:(int)y;
- (void)closeVerticalDoorAtX:(int)x andY:(int)y;

- (BOOL)canMoveFrom:(DoorsCoordinates)position inDirection:(Class)direction;

@end

@interface WorldModel (private) 

- (BOOL)directionImpliesHorizontalDoor:(Class)direction;
- (DoorsDoorCoordinates) doorCoordinatesAt:(DoorsCoordinates)position andDirection:(Class)direction;
- (void)toggleDoor:(DoorLocator)doorLocator;

@end
