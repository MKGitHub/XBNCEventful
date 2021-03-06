//
//  CustomView.m
//  NotificationBasedArchitectureTest
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

