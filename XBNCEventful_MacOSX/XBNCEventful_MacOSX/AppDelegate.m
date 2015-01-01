//
//  AppDelegate.m
//  XBNCEventful_MacOSX
//
//  Created by Mohsan Khan on 2014-12-29.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "AppDelegate.h"

#import "XBNCEventful.h"


@interface AppDelegate ()
@end


@implementation AppDelegate


    #pragma mark - Life Cycle


    + (void)initialize
    {
        if (self == AppDelegate.class)
        {
            // force initialize XBNCEventful
            __unused id xbncEventfulIgnored = XBNCEventful.class;
        }
    }


    #pragma mark - Notifications


    - (void)applicationDidFinishLaunching:(NSNotification *)aNotification
    {
        // Insert code here to initialize your application
    }


    - (void)applicationWillTerminate:(NSNotification *)aNotification
    {
        // Insert code here to tear down your application
    }


@end

