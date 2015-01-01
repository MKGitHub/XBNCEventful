//
//  ViewController.m
//  XBNCEventful_iOS
//
//  Created by Mohsan Khan on 2014-12-29.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "ViewController.h"

#import "XBNCEventful.h"


@interface ViewController ()
@end


@implementation ViewController


    #pragma mark - Life Cycle


    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
    }


    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    #pragma mark - IBActions


    - (IBAction)sliderValueChanged:(UISlider *)sender
    {
        [XBNCEventfulStatic sendEvent:1000
                               sender:self
                                 data:@{@"NewUISliderValue":@(sender.value)}];
    }


    - (IBAction)sendEventButtonTap:(UIButton *)sender
    {
        [XBNCEventfulStatic sendEvent:2000
                               sender:self
                                 data:nil];
    }


@end

