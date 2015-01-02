//
//  AppDelegate.m
//  XBNCEventful_MacOSX
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

