//
//  DoorsDirectionsTest.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DoorsDirectionsTest.h"


@implementation DoorsDirectionsTest

- (void) testUpDirection {
    DoorsVector expected = { 0, 1 };
    STAssertEquals(expected, [DoorsDirectionUp asVector], nil);
}

- (void) testRightDirection {
    DoorsVector expected = { 1, 0 };
    STAssertEquals(expected, [DoorsDirectionRight asVector], nil);
}

- (void) testDownDirection {
    DoorsVector expected = { 0, -1 };
    STAssertEquals(expected, [DoorsDirectionDown asVector], nil);
}

- (void) testLeftDirection {
    DoorsVector expected = { -1, 0 };
    STAssertEquals(expected, [DoorsDirectionLeft asVector], nil);
}

@end
