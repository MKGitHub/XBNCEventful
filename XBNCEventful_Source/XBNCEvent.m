//
//  XBNCEvent.m
//  XBNCEventful
//
//  Created by Mohsan Khan on 2014-12-23.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "XBNCEvent.h"


@implementation XBNCEvent


    - (NSString *)description
    {
        NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];

        [description appendFormat:@"eventId=%lu", (unsigned long)self.eventId];
        [description appendFormat:@", sender=%@", self.sender];
        [description appendFormat:@", data=%@", self.data];
        [description appendFormat:@", triggerCount=%lu", (unsigned long)self.triggerCount];
        [description appendFormat:@", triggerLimit=%lu%@", (unsigned long)(unsigned long)self.triggerLimit, (self.triggerLimit == XBNCEventTriggerLimitUnlimited) ? @" (NSUIntegerMax)" : @""];
        [description appendString:@">"];

        return description;
    }


@end

