//
//  Event2000TextField.m
//  XBNCEventful_iOS
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

#import "Event2000TextField.h"

#import "XBNCEventful.h"


@implementation Event2000TextField


    #pragma mark - Life Cycle


    - (void)dealloc
    {
        [XBNCEventfulStatic stopReceivingEventsForObject:self];
    }


    #pragma mark - User Defined Runtime Attribute


    - (void)setValue:(id)value
              forKey:(NSString *)key
    {
        if ([key isEqualToString:@"receiveEvent2000TriggerLimit"])
        {
            NSNumber *receiveEvent2000TriggerLimit = (NSNumber *)value;

            [XBNCEventfulStatic stopReceivingEventsForObject:self];

            [XBNCEventfulStatic receiveEvent:2000
                                    receiver:self
                                triggerLimit:receiveEvent2000TriggerLimit.unsignedIntegerValue
                                       block:^(XBNCEvent *event)
                                       {
                                           self.text = XBNC_$(@"%lu", (unsigned long)event.triggerCount);
                                       }];
        }
    }


    #pragma mark - Drawing


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    - (void)drawRect:(CGRect)rect {
        // Drawing code
    }
    */


@end

