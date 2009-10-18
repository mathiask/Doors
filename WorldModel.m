//
//  WorldModel.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WorldModel.h"

@implementation DoorKnob

- (id)initWithWorldModel:(WorldModel *)aModel andDoorLocators:(NSArray *)aDoorLocatorArray
{
    if (self = [super init]) {
        worldModel = [aModel retain];
        doorLocators = [aDoorLocatorArray retain];
    }
    return self;
}

- (void)dealloc
{
    [doorLocators release];
    [worldModel release];
    [super dealloc];
}

- (void)toggle
{
    for (DoorLocator *locator in doorLocators) {
        [worldModel toggleDoor:locator];
    }
}

@end


@interface WorldModel () 
- (void)setupDoorKnobs;
- (void)setupPlayerStartPosition;
@end

@implementation WorldModel

@synthesize playerPosition;

- (id)init 
{
    if (self = [super init]) {
        [self openAllDoors];
        [self setupDoorKnobs];
        [self setupPlayerStartPosition];
    }
    return self;
}

- (void)setupDoorKnobs
{
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            doorKnobs[i][j] = nil;
        }
    }
}

- (void)setupPlayerStartPosition 
{
    playerPosition.x = 0;
    playerPosition.y = 2;
}


- (void)dealloc
{
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            [doorKnobs[i][j] release];
        }
    }
    [super dealloc];
}


- (BOOL)isHorizontalDoorOpenAtX:(int)x andY:(int)y 
{
    return x >= 0 && x < 3 && y >= 0 && y < 2 && horizontalDoorsOpen[x][y];
}

- (BOOL)isHorizontalDoorOpen:(DoorsDoorCoordinates)doorCoordinates
{
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

- (BOOL)isVerticalDoorOpen:(DoorsDoorCoordinates)doorCoordinates
{
    return [self isVerticalDoorOpenAtX:doorCoordinates.x andY:doorCoordinates.y];
}


- (void)openAllDoors
{
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            horizontalDoorsOpen[j][i] = YES;
            verticalDoorsOpen[i][j] = YES;
        }
    }
}

- (void)closeVerticalDoorAtX:(int)x andY:(int)y
{
    NSParameterAssert(x >= 0 && x < 2);
    NSParameterAssert(y >= 0 && y < 3);
    verticalDoorsOpen[x][y] = FALSE;
}


- (void)setDoorKnobAtX:(int)x andY:(int)y withDoors:(NSArray *)aDoorLocatorArray
{
    doorKnobs[x][y] = [[DoorKnob alloc] initWithWorldModel:self andDoorLocators:aDoorLocatorArray];
}


- (void)operateDoorKnob 
{
    [self operateDoorKnobAtX: playerPosition.x andY: playerPosition.y];
}

- (BOOL)moveInDirection:(Class)direction
{
    if ([self canMoveFrom: playerPosition inDirection: direction]) {
        playerPosition.x += [direction asVector].x;
        playerPosition.y += [direction asVector].y;
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)playerAtTargetPosition {
    return playerPosition.x == 2 && playerPosition.y == 0;
}


// private methods

- (BOOL)directionImpliesHorizontalDoor:(Class)direction 
{
    DoorsVector vector = [direction asVector];
    return vector.y != 0;
}

- (DoorsDoorCoordinates)doorCoordinatesAt:(DoorsCoordinates)position andDirection:(Class)direction 
{
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


- (void)toggleDoor:(DoorLocator *)doorLocator 
{
    DoorsDoorCoordinates c = [doorLocator coordinates];
    if ([doorLocator horizontalDoor])
        horizontalDoorsOpen[c.x][c.y] = !horizontalDoorsOpen[c.x][c.y];
    else
        verticalDoorsOpen[c.x][c.y] = !verticalDoorsOpen[c.x][c.y];
}


- (BOOL)canMoveFrom:(DoorsCoordinates)position inDirection:(Class)direction 
{
    DoorsDoorCoordinates doorCoordinates = [self doorCoordinatesAt:position andDirection:direction];
    return [self directionImpliesHorizontalDoor:direction] ?
    [self isHorizontalDoorOpen:doorCoordinates] :
    [self isVerticalDoorOpen:doorCoordinates];
}


- (void)operateDoorKnobAtX:(int)x andY:(int)y
{
    [doorKnobs[x][y] toggle];
}

@end
