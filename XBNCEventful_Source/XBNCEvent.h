//
//  XBNCEvent.h
//  XBNCEventful
//
//  Created by Mohsan Khan on 2014-12-23.
//  Copyright (c) 2014 Xybernic. All rights reserved.
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

