//
//  XBNCEventful.h
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
#import "XBNCEvent.h"
#import "XBNCEventReceiver.h"

@class XBNCEvent;


/*!
 * @class  The core XBNCEventful class with all the logic and awesomeness.
 *
 * @since 1.0.0
 */


@interface XBNCEventful:NSObject

    /*!
     * @brief  The singleton shared instance object.
     */
    + (XBNCEventful *)sharedInstance;

    /*!
     * @brief  Send an event.
     *
     * @param eventId The event id.
     * @param sender  The object/owner which is sending the event.
     * @param data    Data to pass to the receiver.
     *
     * @since 1.0.0
     */
    - (void)sendEvent:(NSUInteger)eventId
               sender:(id)sender
                 data:(NSDictionary *)data;

    /*!
     * @brief  Send an event.
     *
     * @param eventId The event id.
     * @param sender  The object/owner which is sending the event.
     * @param data    Data to pass to the receiver.
     * @param onSuccess Block to call when the event is successfully sent & received.
     * @param onFail Block to call when the event fails to be sent & received.
     *
     * @since 1.0.0
     */
    - (void)sendEvent:(NSUInteger)eventId
               sender:(id)sender
                 data:(NSDictionary *)data
            onSuccess:(void (^)(void))onSuccess
               onFail:(void (^)(void))onFail;

    /*!
     * @brief  Receive an event.
     *
     * @param eventId  The event id.
     * @param receiver The object which is to receive the event.
     * @param selector The method which will handle receiving the event.
     *
     * @since 1.0.0
     */
    - (void)receiveEvent:(NSUInteger)eventId
                receiver:(id)receiver
                selector:(SEL)selector;

        /*!
         * @brief  Receive an event.
         *
         * @param eventId      The event id.
         * @param triggerLimit Maximum number of times the event can be received.
         * @param receiver     The object which is to receive the event.
         * @param selector     The method which will handle receiving the event.
         *
         * @since 1.0.0
         */
    - (void)receiveEvent:(NSUInteger)eventId
            triggerLimit:(XBNCEventTriggerLimit)triggerLimit
                receiver:(id)receiver
                selector:(SEL)selector;

    /*!
     * @brief  Receive an event.
     *
     * @param eventId  The event id.
     * @param receiver The object which is to receive the event.
     * @param block    The block which will handle receiving the event.
     *
     * @since 1.0.0
     */
    - (void)receiveEvent:(NSUInteger)eventId
                receiver:(id)receiver
                   block:(void (^)(XBNCEvent *))block;

    /*!
     * @brief  Receive an event.
     *
     * @param eventId  The event id.
     * @param receiver The object which is to receive the event.
     * @param triggerLimit Maximum number of times the event can be received.
     * @param block    The block which will handle receiving the event.
     *
     * @since 1.0.0
     */
    - (void)receiveEvent:(NSUInteger)eventId
                receiver:(id)receiver
            triggerLimit:(XBNCEventTriggerLimit)triggerLimit
                   block:(void (^)(XBNCEvent *))block;

    /*!
     * @brief  Stop receiving an event.
     *
     * @param eventId  The event id.
     * @param receiver The object which is to stop receiving the event.
     *
     * @since 1.0.0
     */
    - (void)stopReceivingEventId:(NSUInteger)eventId forReceiver:(id)receiver;

    /*!
     * @brief  Stop receiving all events, if any.
     *
     * @discussion Normally you would call this in the dealloc method of your class,
     *             to simply and easily stop receiving all events and release the object from the event pool.
     *
     * @param receiver The object which is to stop receiving all events.
     *
     * @since 1.0.0
     */
    - (void)stopReceivingEventsForObject:(id)receiver;

    /*!
     * @brief  Prints out a nice log to the standard console, with information regarding all events in the pool.
     *
     * @since 1.0.0
     */
    - (void)eventsDescription;

    /*!
     * @brief  Prints out a nice log to the standard console, with information regarding all receivers in the pool.
     *
     * @since 1.0.0
     */
    - (void)receiversDescription;

    /*!
     * @brief  Prints out a nice log to the standard console, with information regarding all events & receivers in the pool.
     *
     * @since 1.0.0
     */
    - (void)eventsAndReceiversDescription;

@end


/*!
 * @brief  Public static symbol of singleton.
 *
 * @since 1.0.0
 */
extern XBNCEventful *XBNCEventfulStatic;

