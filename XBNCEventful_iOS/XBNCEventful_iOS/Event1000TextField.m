//
//  Event1000TextField.m
//  XBNCEventful_iOS
//
//  Created by Mohsan Khan on 2014-12-31.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "Event1000TextField.h"

#import "XBNCEventful.h"


@implementation Event1000TextField


    #pragma mark - Life Cycle


    - (void)commonInit
    {
        [XBNCEventfulStatic receiveEvent:1000
                                receiver:self
                                selector:@selector(receiveValueChangedEvent:)];
    }


    - (id)initWithFrame:(CGRect)frameRect
    {
        if ((self = [super initWithFrame:frameRect]))
        {
            [self commonInit];
        }

        return self;
    }


    - (id)initWithCoder:(NSCoder *)coder
    {
        if ((self = [super initWithCoder:coder]))
        {
            [self commonInit];
        }

        return self;
    }


    - (void)dealloc
    {
        [XBNCEventfulStatic stopReceivingEventsForObject:self];
    }


    #pragma mark - Event


    - (void)receiveValueChangedEvent:(XBNCEvent *)event
    {
        NSNumber *uiSliderValue = event.data[@"NewUISliderValue"];

        self.text = XBNC_$(@"%lu", (unsigned long)uiSliderValue.unsignedIntegerValue);
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

