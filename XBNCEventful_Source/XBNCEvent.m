//
//  XBNCEvent.m
//  XBNCEventful
//
//  https://github.com/MKGitHub/XBNCEventful
//  http://www.xybernic.com
//  http://www.khanofsweden.com
//
//  Copyright 2014 Mohsan Khan
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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

