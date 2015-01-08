//
//  XBNCEvent.h
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

#import "XBNCHeader.h"


/*!
 * @class  The event object.
 *
 * @since 1.0.0
 */


@interface XBNCEvent:NSObject

    /*!
     * @property eventId
     * The event id.
     */
    @property (assign, nonatomic) NSUInteger eventId;

    /*!
     * @property sender
     * The object/owner which is sending the event.
     */
    @property (strong, nonatomic) id sender;

    /*!
     * @property data
     * Data to pass to the receiver.
     */
    @property (strong, nonatomic) NSDictionary *data;

    /*!
     * @property triggerCount
     * Number of times the event has been received.
     */
    @property (assign, nonatomic) NSUInteger triggerCount;

    /*!
     * @property triggerLimit
     * Maximum number of times the event can be received.
     */
    @property (assign, nonatomic) XBNCEventTriggerLimit triggerLimit;

@end

