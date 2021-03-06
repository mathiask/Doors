//
//  WorldModelTest.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WorldModelTest.h"

@implementation WorldModelTest

- (void)setUp
{
    model = [WorldModel new];
}

- (void)tearDown
{
    [model release];
}

- (void)testHorizontalDoorsAreInitiallyOpen
{
    for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 3; x++) {
            STAssertTrue([model isHorizontalDoorOpenAtX:x andY:y], nil);
        }
    }
}

- (void)testHorizontalDoorClosed
{
    [model closeHorizontalDoorAtX:1 andY:1];
    STAssertFalse([model isHorizontalDoorOpenAtX:1 andY:1], nil);
}


- (void)testVerticalDoorsAreInitiallyOpen
{
    for (int y = 0; y < 3; y++) {
        for (int x = 0; x < 2; x++) {
            STAssertTrue([model isVerticalDoorOpenAtX:x andY:y], nil);
        }
    }
}

- (void)testVerticalDoorClosed
{
    [model closeVerticalDoorAtX:1 andY:1];
    STAssertFalse([model isVerticalDoorOpenAtX:1 andY:1], nil);
}


- (void)testUpImpliesHorizontal 
{
    STAssertTrue([model directionImpliesHorizontalDoor:[DoorsDirectionUp class]], nil);
}

- (void)testRightImpliesHorizontal 
{
    STAssertFalse([model directionImpliesHorizontalDoor:[DoorsDirectionRight class]], nil);
}

- (void)testDownImpliesHorizontal 
{
    STAssertTrue([model directionImpliesHorizontalDoor:[DoorsDirectionDown class]], nil);
}

- (void)testLeftImpliesHorizontal 
{
    STAssertFalse([model directionImpliesHorizontalDoor:[DoorsDirectionLeft class]], nil);
}


- (void)testDoorCoordinatesAtAndDirectionUp 
{
    DoorsCoordinates position = { 1, 1 };
    DoorsDoorCoordinates expected = { 1, 1 };
    STAssertEquals(expected, [model doorCoordinatesAt:position andDirection:[DoorsDirectionUp class]], nil);
}

- (void)testDoorCoordinatesAtAndDirectionRight 
{
    DoorsCoordinates position = { 1, 1 };
    DoorsDoorCoordinates expected = { 1, 1 };
    STAssertEquals(expected, [model doorCoordinatesAt:position andDirection:[DoorsDirectionRight class]], nil);
}

- (void)testDoorCoordinatesAtAndDirectionDown 
{
    DoorsCoordinates position = { 1, 1 };
    DoorsDoorCoordinates expected = { 1, 0 };
    STAssertEquals(expected, [model doorCoordinatesAt:position andDirection:[DoorsDirectionDown class]], nil);
}

- (void)testDoorCoordinatesAtAndDirectionLeft 
{
    DoorsCoordinates position = { 1, 1 };
    DoorsDoorCoordinates expected = { 0, 1 };
    STAssertEquals(expected, [model doorCoordinatesAt:position andDirection:[DoorsDirectionLeft class]], nil);
}


- (void)testVerticalDoor01ImpassableFromLeft 
{
    [model closeVerticalDoorAtX:0 andY:1];
    DoorsCoordinates position = { 0, 1 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionRight class]], nil);
}

- (void)testVerticalDoor01ImpassableFromRight 
{
    [model closeVerticalDoorAtX:0 andY:1];
    DoorsCoordinates position = { 1, 1 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionLeft class]], nil);
}

- (void)testVerticalDoor01PassableFromUnrelatedCell 
{
    [model closeVerticalDoorAtX:0 andY:1];
    DoorsCoordinates position = { 1, 2 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionLeft class]], nil);
}

- (void)testVerticalDoor01PassableForAllUps 
{
    [model closeVerticalDoorAtX:0 andY:1];
    for (int x = 0; x < 3; x++) {
        for (int y = 0; y < 2; y++) {
            DoorsCoordinates position = { x, y };
            STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionUp class]], nil);
        }
    }
}

- (void)testVerticalDoor01PassableForAllDowns 
{
    [model closeVerticalDoorAtX:0 andY:1];
    for (int x = 0; x < 3; x++) {
        for (int y = 1; y < 3; y++) {
            DoorsCoordinates position = { x, y };
            STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionDown class]], nil);
        }
    }
}


- (void)testHorizontalDoor01ImpassableFromBelow 
{
    [model closeHorizontalDoorAtX:0 andY:1];
    DoorsCoordinates position = { 0, 1 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionUp class]], nil);
}

- (void)testHorizontalDoor01ImpassableFromAbove 
{
    [model closeHorizontalDoorAtX:0 andY:1];
    DoorsCoordinates position = { 0, 2 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionDown class]], nil);
}

- (void)testHorizontalDoor01PassableFromUnrelatedCell 
{
    [model closeHorizontalDoorAtX:0 andY:1];
    DoorsCoordinates position = { 1, 2 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionDown class]], nil);
}

- (void)testHorizontalDoor01PassableForAllRights 
{
    [model closeHorizontalDoorAtX:0 andY:1];
    for (int x = 0; x < 2; x++) {
        for (int y = 0; y < 3; y++) {
            DoorsCoordinates position = { x, y };
            STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionRight class]], nil);
        }
    }
}

- (void)testHorizontalDoor01PassableForAllLefts 
{
    [model closeHorizontalDoorAtX:0 andY:1];
    for (int x = 1; x < 3; x++) {
        for (int y = 0; y < 3; y++) {
            DoorsCoordinates position = { x, y };
            STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionLeft class]], nil);
        }
    }
}


- (void)testBottomLeftCornerUp 
{
    DoorsCoordinates position = { 0, 0 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionUp class]], nil);
}

- (void)testBottomLeftCornerRight 
{
    DoorsCoordinates position = { 0, 0 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionRight class]], nil);
}

- (void)testBottomLeftCornerDown 
{
    DoorsCoordinates position = { 0, 0 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionDown class]], nil);
}

- (void)testBottomLeftCornerLeft 
{
    DoorsCoordinates position = { 0, 0 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionLeft class]], nil);
}

- (void)testBottomRightCornerUp 
{
    DoorsCoordinates position = { 2, 0 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionUp class]], nil);
}

- (void)testBottomRightCornerRight 
{
    DoorsCoordinates position = { 2, 0 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionRight class]], nil);
}

- (void)testBottomRightCornerDown 
{
    DoorsCoordinates position = { 2, 0 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionDown class]], nil);
}

- (void)testBottomRightCornerLeft {
    DoorsCoordinates position = { 2, 0 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionLeft class]], nil);
}


- (void)testTopLeftCornerUp 
{
    DoorsCoordinates position = { 0, 2 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionUp class]], nil);
}

- (void)testTopLeftCornerRight {
    DoorsCoordinates position = { 0, 2 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionRight class]], nil);
}

- (void)testTopLeftCornerDown 
{
    DoorsCoordinates position = { 0, 2 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionDown class]], nil);
}

- (void)testTopLeftCornerLeft 
{
    DoorsCoordinates position = { 0, 2 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionLeft class]], nil);
}

- (void)testTopRightCornerUp 
{
    DoorsCoordinates position = { 2, 2 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionUp class]], nil);
}

- (void)testTopRightCornerRight 
{
    DoorsCoordinates position = { 2, 2 };
    STAssertFalse([model canMoveFrom:position inDirection:[DoorsDirectionRight class]], nil);
}

- (void)testTopRightCornerDown 
{
    DoorsCoordinates position = { 2, 2 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionDown class]], nil);
}

- (void)testTopRightCornerLeft 
{
    DoorsCoordinates position = { 2, 2 };
    STAssertTrue([model canMoveFrom:position inDirection:[DoorsDirectionLeft class]], nil);
}


- (void)testToggleDoorOnHorizontalDoor {
    DoorLocator *locator = [DoorLocator newWithHorizontalDoor:HORIZONTAL_DOOR x:1 y:1];
    [model toggleDoor:locator];
    STAssertFalse([model isHorizontalDoorOpen:[locator coordinates]], nil);
}

- (void)testToggleDoorTwice 
{
    DoorLocator *locator = [DoorLocator newWithHorizontalDoor:HORIZONTAL_DOOR x:1 y:1];
    [model toggleDoor:locator];
    [model toggleDoor:locator];
    STAssertTrue([model isHorizontalDoorOpen:[locator coordinates]], nil);
}

- (void)testToggleDoorLeavesOtherDoorsInPeace 
{
    DoorLocator *locator = [DoorLocator newWithHorizontalDoor:HORIZONTAL_DOOR x:1 y:1];
    DoorsDoorCoordinates other = { 0, 1};
    [model toggleDoor:locator];
    STAssertTrue([model isHorizontalDoorOpen:other], nil);
}

- (void)testToggleDoorOnVerticalDoor 
{
    DoorLocator *locator = [DoorLocator newWithHorizontalDoor:VERTICAL_DOOR x:1 y:1];
    DoorsDoorCoordinates dc = { 1, 1};
    [model toggleDoor:locator];
    STAssertFalse([model isVerticalDoorOpen:dc], nil);
}


- (void)testToggleUsingDoorKnob
{
    DoorLocator *locator1 = [DoorLocator newWithHorizontalDoor:true x:1 y:2];
    DoorLocator *locator2 = [DoorLocator newWithHorizontalDoor:false x:2 y:0];
    NSArray *locators = [NSArray arrayWithObjects: locator1, locator2];
    DoorKnob *doorKnob = [[DoorKnob alloc] initWithWorldModel:model andDoorLocators:locators];
    [doorKnob toggle];
    STAssertFalse([model isHorizontalDoorOpen:[locator1 coordinates]], nil); 
    STAssertFalse([model isHorizontalDoorOpen:[locator2 coordinates]], nil); 
}


- (void)testCanOperateEmptyDoorKnob
{
    [model operateDoorKnobAtX:1 andY:1];
}


- (void)testIntegratedOperateDoorKnob
{
    // setup
    DoorLocator *locator1 = [DoorLocator newWithHorizontalDoor:true x:1 y:2];
    DoorLocator *locator2 = [DoorLocator newWithHorizontalDoor:false x:2 y:0];
    NSArray *locators = [NSArray arrayWithObjects: locator1, locator2];
    [model setDoorKnobAtX:1 andY:1 withDoors:locators];
    // execute
    [model operateDoorKnobAtX:1 andY:1];
    // validate
    STAssertFalse([model isHorizontalDoorOpenAtX:1 andY:2], nil);
    STAssertFalse([model isVerticalDoorOpenAtX:2 andY:0], nil);
}


- (void)testPlayerStartPosition
{
    DoorsCoordinates expectedPosition = {0, 2};
    STAssertEquals(expectedPosition, [model playerPosition], nil);
}


- (void)closeDoorV11AndMakeDoorKnobForItAt11AntPlacePlayerThere
{
    [model closeVerticalDoorAtX:1 andY:1];
    [model 
        setDoorKnobAtX:1 
        andY:1 
        withDoors:[NSArray arrayWithObject:[DoorLocator newWithHorizontalDoor:VERTICAL_DOOR x:1 y:1]]];
    DoorsCoordinates playerPosition = {1, 1};
    [model setPlayerPosition:playerPosition];
}

- (void)testPlayerCanMoveThroughOpenDoor
{
    [self closeDoorV11AndMakeDoorKnobForItAt11AntPlacePlayerThere];
    DoorsCoordinates expectedPosition = {1, 2};
    STAssertTrue([model moveInDirection:[DoorsDirectionUp class]], nil);
    STAssertEquals(expectedPosition, [model playerPosition], nil);
}

- (void)testPlayerCannotMoveThroughClosedDoor
{
    [self closeDoorV11AndMakeDoorKnobForItAt11AntPlacePlayerThere];
    DoorsCoordinates expectedPosition = {1, 1};
    STAssertFalse([model moveInDirection:[DoorsDirectionRight class]], nil);
    STAssertEquals(expectedPosition, [model playerPosition], nil);
}

- (void)testPlayerCannMoveThroughDoorAfterOpeningIt
{
    [self closeDoorV11AndMakeDoorKnobForItAt11AntPlacePlayerThere];
    DoorsCoordinates expectedPosition = {2, 1};
    [model operateDoorKnob];
    STAssertTrue([model moveInDirection:[DoorsDirectionRight class]], nil);
    STAssertEquals(expectedPosition, [model playerPosition], nil);
}


- (void)testPlayerInitiallyNotAtTarget
{
    STAssertFalse([model playerAtTargetPosition], nil);
}

- (void)testPlayerAtTarget
{
    DoorsCoordinates targetPosition = {2, 0};
    [model setPlayerPosition:targetPosition];
    STAssertTrue([model playerAtTargetPosition], nil);
}

@end
