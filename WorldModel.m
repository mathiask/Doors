//
//  WorldModel.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WorldModel.h"

@implementation WorldModel

- (id)init 
{
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            horizontalDoorsOpen[j][i] = YES;
            verticalDoorsOpen[i][j] = YES;
        }
    }
    return self;
}

- (BOOL)isHorizontalDoorOpenAtX:(int)x andY:(int)y 
{
    return x >= 0 && x < 3 && y >= 0 && y < 2 && horizontalDoorsOpen[x][y];
}

- (BOOL)isHorizontalDoorOpen:(DoorsDoorCoordinates)doorCoordinates{
    return [self isHorizontalDoorOpenAtX:doorCoordinates.x andY:doorCoordinates.y];
}

- (void)closeHorizontalDoorAtX:(int)x andY:(int)y
{
    NSParameterAssert(x >= 0 && x < 3);
    NSParameterAssert(y >= 0 && y < 2);
    horizontalDoorsOpen[x][y] = FALSE;
}

- (BOOL)isVerticalDoorOpenAtX:(int)x andY:(int)y 
{
    return x >= 0 && x < 2 && y >= 0 && y < 3 && verticalDoorsOpen[x][y];
}

- (BOOL)isVerticalDoorOpen:(DoorsDoorCoordinates)doorCoordinates{
    return [self isVerticalDoorOpenAtX:doorCoordinates.x andY:doorCoordinates.y];
}

- (void)closeVerticalDoorAtX:(int)x andY:(int)y
{
    NSParameterAssert(x >= 0 && x < 2);
    NSParameterAssert(y >= 0 && y < 3);
    verticalDoorsOpen[x][y] = FALSE;
}

- (BOOL)canMoveFrom:(DoorsCoordinates)position inDirection:(Class)direction {
    DoorsDoorCoordinates doorCoordinates = [self doorCoordinatesAt:position andDirection:direction];
    return [self directionImpliesHorizontalDoor:direction] ?
        [self isHorizontalDoorOpen:doorCoordinates] :
        [self isVerticalDoorOpen:doorCoordinates];
}

// private methods

- (BOOL)directionImpliesHorizontalDoor:(Class)direction {
    DoorsVector vector = [direction asVector];
    return vector.y != 0;
}

- (DoorsDoorCoordinates) doorCoordinatesAt:(DoorsCoordinates)position andDirection:(Class)direction {
    DoorsVector vector = [direction asVector];
    DoorsDoorCoordinates d;    
    if ([self directionImpliesHorizontalDoor:direction]) {
        d.x = position.x;
        d.y = position.y - (vector.y < 0 ? 1 : 0);
    } else {
        d.x = position.x - (vector.x < 0 ? 1 : 0);
        d.y = position.y;
    }
    return d;
}

@end
