//
//  ViewController.m
//  XBNCEventful_MacOSX
//
//  Created by Mohsan Khan on 2014-12-29.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "ViewController.h"

#import "XBNCEventful.h"


@implementation ViewController


    #pragma mark - Life Cycle


    - (void)viewDidLoad
    {
        [super viewDidLoad];

        // Do any additional setup after loading the view.
    }


    - (void)setRepresentedObject:(id)representedObject
    {
        [super setRepresentedObject:representedObject];

        // Update the view, if already loaded.
    }


    #pragma mark - IBActions


    - (IBAction)colorChanged:(NSColorWell *)sender
    {
        [XBNCEventfulStatic sendEvent:1000
                               sender:self
                                 data:@{@"NewNSColor":sender.color}];
    }


    - (IBAction)sendEventButtonClicked:(NSButton *)sender
    {
        [XBNCEventfulStatic sendEvent:2000
                               sender:self
                                 data:nil];
    }


@end

