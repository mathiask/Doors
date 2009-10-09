//
//  WorldModelTest.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WorldModelTest.h"

@implementation WorldModelTest

- (void) setUp
{
    model = [WorldModel new];
}

- (void)tearDown
{
    [model release];
}

- (void) testHorizontalDoorsAreInitiallyOpen
{
    for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 3; x++) {
            STAssertTrue([model isHorizontalDoorOpenAtX:x andY:y], nil);
        }
    }
}

- (void) testHorizontalDoorClosed
{
    [model closeHorizontalDoorAtX:1 andY:1];
    STAssertFalse([model isHorizontalDoorOpenAtX:1 andY:1], nil);
}

-(void) testVerticalDoorsAreInitiallyOpen
{
    for (int y = 0; y < 3; y++) {
        for (int x = 0; x < 2; x++) {
            STAssertTrue([model isVerticalDoorOpenAtX:x andY:y], nil);
        }
    }
}

- (void) testVerticalDoorClosed
{
    [model closeVerticalDoorAtX:1 andY:1];
    STAssertFalse([model isVerticalDoorOpenAtX:1 andY:1], nil);
}

- (void) testUpImpliesHorizontal {
    STAssertFalse([model directionImpliesHorizontalDoor:[DoorsDirectionUp class]], nil);
}

- (void) testRightImpliesHorizontal {
    STAssertTrue([model directionImpliesHorizontalDoor:[DoorsDirectionRight class]], nil);
}

- (void) testDownImpliesHorizontal {
    STAssertFalse([model directionImpliesHorizontalDoor:[DoorsDirectionDown class]], nil);
}

- (void) testLeftImpliesHorizontal {
    STAssertTrue([model directionImpliesHorizontalDoor:[DoorsDirectionLeft class]], nil);
}

- (void)testDoorCoordinatesAtAndDirectionUp {
    DoorsCoordinates position = { 1, 1 };
    DoorsDoorCoordinates expected = { 1, 1 };
    STAssertEquals(expected, [model doorCoordinatesAt:position andDirection:[DoorsDirectionUp class]], nil);
}

- (void)testDoorCoordinatesAtAndDirectionRight {
    DoorsCoordinates position = { 1, 1 };
    DoorsDoorCoordinates expected = { 1, 1 };
    STAssertEquals(expected, [model doorCoordinatesAt:position andDirection:[DoorsDirectionRight class]], nil);
}

- (void)testDoorCoordinatesAtAndDirectionDown {
    DoorsCoordinates position = { 1, 1 };
    DoorsDoorCoordinates expected = { 1, 0 };
    STAssertEquals(expected, [model doorCoordinatesAt:position andDirection:[DoorsDirectionDown class]], nil);
}

- (void)testDoorCoordinatesAtAndDirectionLeft {
    DoorsCoordinates position = { 1, 1 };
    DoorsDoorCoordinates expected = { 0, 1 };
    STAssertEquals(expected, [model doorCoordinatesAt:position andDirection:[DoorsDirectionLeft class]], nil);
}


@end
