//
//  DoorsDirections.m
//  Doors
//
//  Created by Mathias Kegelmann on 10/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DoorsDirections.h"

@implementation DoorsDirectionUp
+ (DoorsVector)asVector
{
    DoorsVector up = {0, 1};
    return up;
}
@end

@implementation DoorsDirectionRight
+ (DoorsVector)asVector
{
    DoorsVector up = {1, 0};
    return up;
}
@end

@implementation DoorsDirectionDown
+ (DoorsVector)asVector
{
    DoorsVector up = {0, -1};
    return up;
}
@end

@implementation DoorsDirectionLeft
+ (DoorsVector)asVector
{
    DoorsVector up = {-1, 0};
    return up;
}
@end
