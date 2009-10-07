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
    NSParameterAssert(x >= 0 && x < 3);
    NSParameterAssert(y >= 0 && y < 2);
    return horizontalDoorsOpen[x][y];
}

- (void)closeHorizontalDoorAtX:(int)x andY:(int)y
{
    NSParameterAssert(x >= 0 && x < 3);
    NSParameterAssert(y >= 0 && y < 2);
    horizontalDoorsOpen[x][y] = FALSE;
}

- (BOOL)isVerticalDoorOpenAtX:(int)x andY:(int)y 
{
    NSParameterAssert(x >= 0 && x < 2);
    NSParameterAssert(y >= 0 && y < 3);
    return verticalDoorsOpen[x][y];
}

- (void)closeVerticalDoorAtX:(int)x andY:(int)y
{
    NSParameterAssert(x >= 0 && x < 2);
    NSParameterAssert(y >= 0 && y < 3);
    verticalDoorsOpen[x][y] = FALSE;
}

@end
