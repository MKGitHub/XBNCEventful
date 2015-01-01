//
//  CustomTextField.m
//  XBNCEventful_MacOSX
//
//  Created by Mohsan Khan on 2014-12-31.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "CustomTextField.h"

#import "XBNCEventful.h"


@implementation CustomTextField


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
                                           self.integerValue = event.triggerCount;
                                       }];
        }
    }


    #pragma mark - Drawing


    /*- (void)drawRect:(NSRect)dirtyRect
    {
        [super drawRect:dirtyRect];

        // Drawing code here.
    }*/


@end

