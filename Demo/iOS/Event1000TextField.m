//
//  Event1000TextField.m
//  DemoiOS
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

