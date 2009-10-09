//
//  DoorsDirections.h
//  Doors
//
//  Created by Mathias Kegelmann on 10/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

struct DoorsCoordinates {
    int x;
    int y;
};
typedef struct DoorsCoordinates DoorsCoordinates;
typedef DoorsCoordinates DoorsVector;
typedef DoorsCoordinates DoorsDoorCoordinates;


@protocol DoorsDirection
+ (DoorsVector)asVector;
@end

@interface DoorsDirectionUp    : NSObject <DoorsDirection> @end
@interface DoorsDirectionRight : NSObject <DoorsDirection> @end
@interface DoorsDirectionDown  : NSObject <DoorsDirection> @end
@interface DoorsDirectionLeft  : NSObject <DoorsDirection> @end