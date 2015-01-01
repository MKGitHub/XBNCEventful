//
//  XBNCEventReceiver.m
//  XBNCEventful
//
//  Created by Mohsan Khan on 2014-12-24.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "XBNCEventReceiver.h"


@implementation XBNCEventReceiver


    - (NSString *)description
    {
        NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];

        [description appendFormat:@"triggerCount=%lu", (unsigned long)self.triggerCount];
        [description appendFormat:@", triggerLimit=%lu", (unsigned long)self.triggerLimit];
        [description appendFormat:@", object=%@", self.object];
        [description appendFormat:@", selector=%p", self.selector];
        [description appendFormat:@", receiverBlock=%p", self.receiverBlock];
        [description appendString:@">"];

        return description;
    }


@end

