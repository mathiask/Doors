//
//  DoorLocatorTest.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DoorLocatorTest.h"
#import "DoorLocator.h"

@implementation DoorLocatorTest

- (void)testConstructor{
    DoorLocator *locator = [DoorLocator newWithHorizontalDoor:YES x:42 y:17];
    STAssertTrue([locator horizontalDoor], nil);
    STAssertEquals(42, [locator x], nil);
    STAssertEquals(17, [locator y], nil);
    
    DoorsDoorCoordinates coordinates = { 42, 17 };
    STAssertEquals(coordinates, [locator coordinates], nil);
}

@end
