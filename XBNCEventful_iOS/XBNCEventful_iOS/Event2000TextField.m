//
//  Event2000TextField.m
//  XBNCEventful_iOS
//
//  Created by Mohsan Khan on 2014-12-31.
//  Copyright (c) 2014 Xybernic. All rights reserved.
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

