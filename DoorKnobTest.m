//
//  DoorKnobTest.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DoorKnobTest.h"

@interface WorldSpy : NSObject {
    NSMutableArray *trace;
}
@property(readonly) NSMutableArray *trace;
- (id)init;
- (void)toggleDoor:(DoorLocator *)doorLocator;
@end

@implementation WorldSpy
- (id)init 
{
    trace = [NSMutableArray new];
    return self;
}

- (void)toggleDoor:(DoorLocator *)doorLocator
{
    [trace addObject:doorLocator];
}
@synthesize trace;
@end


@implementation DoorKnobTest
    
- (void)testToggle
{
    DoorLocator *locator1 = [DoorLocator newWithHorizontalDoor:true x:1 y:2];
    DoorLocator *locator2 = [DoorLocator newWithHorizontalDoor:false x:2 y:0];
    NSArray *locators = [NSArray arrayWithObjects: locator1, locator2];
    id world = [[WorldSpy alloc] init];
    DoorKnob *doorKnob = [[DoorKnob alloc] initWithWorldModel:world andDoorLocators:locators];
    [doorKnob toggle];
    STAssertEqualObjects(locators, [world trace], nil); 
}

@end
