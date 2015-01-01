//
//  CustomView.m
//  NotificationBasedArchitectureTest
//
//  Created by Mohsan Khan on 2014-12-29.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "CustomView.h"

#import "XBNCEventful.h"


@interface CustomView ()
    @property (strong, nonatomic) NSColor *customFillColor;
@end


@implementation CustomView


    #pragma mark - Life Cycle


    - (void)commonInit
    {
        [XBNCEventfulStatic receiveEvent:1000
                                receiver:self
                                selector:@selector(receiveColorChangedEvent:)];
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


    - (void)receiveColorChangedEvent:(XBNCEvent *)event
    {
        NSColor *color = event.data[@"NewNSColor"];

        // set color and redraw
        _customFillColor = color;
        [self setNeedsDisplay:YES];
    }


    #pragma mark - Drawing


    - (CGColorRef)NSColorToCGColor:(NSColor *)color
    {
        const NSInteger numberOfComponents = [color numberOfComponents];
        const CGFloat components[numberOfComponents];
        CGColorSpaceRef colorSpace = [[color colorSpace] CGColorSpace];

        [color getComponents:(CGFloat *)&components];

        CGColorRef cgColor = CGColorCreate(colorSpace, components);

        return cgColor;
    }


    - (void)drawRect:(NSRect)dirtyRect
    {
        CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
        CGContextSetFillColorWithColor(context, [self NSColorToCGColor:_customFillColor]);
        CGContextFillRect(context, NSRectToCGRect(dirtyRect));
    }


@end

