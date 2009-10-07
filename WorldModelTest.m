//
//  WorldModelTest.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WorldModelTest.h"


@implementation WorldModelTest
-(void) setUp
{
    model = [WorldModel new];
}

-(void)tearDown
{
    [model release];
}

-(void) testHorizontalDoorsAreInitiallyOpen
{
    for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 3; x++) {
            STAssertTrue([model isHorizontalDoorOpenAtX:x andY:y], nil);
        }
    }
}

-(void) testHorizontalDoorClosed
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

-(void) testVerticalDoorClosed
{
    [model closeVerticalDoorAtX:1 andY:1];
    STAssertFalse([model isVerticalDoorOpenAtX:1 andY:1], nil);
}



@end
