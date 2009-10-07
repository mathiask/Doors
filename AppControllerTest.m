//
//  AppControllerTest.m
//  Doors
//
//  Created by Mathias Kegelmann on 8/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AppControllerTest.h"


@implementation AppControllerTest
-(void) setUp
{
    appController = [AppController new];
}

-(void)tearDown
{
    [appController release];
}

-(void) testDoorsAreInitiallyOpen
{
    STAssertFalse([appController doorsClosed], nil);
}


-(void) testStartOpensDoor
{
    [appController start:nil];
    STAssertTrue([appController doorsClosed], nil);  
}

-(void) testResetClosesDoorAgain
{
    [appController start:nil];
    [appController reset:nil];
    STAssertFalse([appController doorsClosed], nil);
}

@end
