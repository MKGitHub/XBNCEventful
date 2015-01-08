//
//  XBNCEventReceiver.h
//  XBNCEventful
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

#import "TargetConditionals.h" 

#if TARGET_OS_IPHONE
    @import UIKit;
#else
    @import Cocoa;
#endif

#import "XBNCEvent.h"
#import "XBNCHeader.h"


/*!
 * @internal  Event receiver object.
 *
 * @discussion Internally used by the XBNCEventful library.
 *
 * @since 1.0.0
 */


@interface XBNCEventReceiver:NSObject

    @property (assign, nonatomic) NSUInteger triggerCount;
    @property (assign, nonatomic) XBNCEventTriggerLimit triggerLimit;

    @property (strong, nonatomic) id object;
    @property (assign, nonatomic) SEL selector;

    @property (strong, nonatomic) void (^receiverBlock)(XBNCEvent *);

@end

