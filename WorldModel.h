//
//  WorldModel.h
//  Doors
//
//  Created by Mathias Kegelmann on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WorldModel : NSObject {
    BOOL horizontalDoorsOpen[3][2];
    BOOL verticalDoorsOpen[2][3];
}

- (BOOL)isHorizontalDoorOpenAtX:(int)x andY:(int)y;
- (void)closeHorizontalDoorAtX:(int)x andY:(int)y;
- (BOOL)isVerticalDoorOpenAtX:(int)x andY:(int)y;
- (void)closeVerticalDoorAtX:(int)x andY:(int)y;

@end
