//
//  XBNCEventful.m
//  XBNCEventful
//
//  Created by Mohsan Khan on 2014-12-23.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "XBNCEventful.h"


/*!
 * @static  Public static symbol of singleton.
 *
 * @since 1.0.0
 */
XBNCEventful *XBNCEventfulStatic;


@interface XBNCEventful ()
    @property (strong, atomic) NSMutableDictionary *events;       // [eventId] = [receiver, receiver, …]
    @property (strong, atomic) NSMutableDictionary *receivers;    // [receiver] = [eventId, eventId, eventId, …]
@end


@implementation XBNCEventful


    /*!
     * @static  Singleton private members.
     *
     * @since 1.0.0
     */
    static XBNCEventful *mSingleton = nil;
    static bool mIsFirstAccess = YES;


    #pragma mark - Life Cycle


    /*
        See alt-click quick help documentation.
    */
    + (void)initialize
    {
        if (self == XBNCEventful.class)
        {
            __unused id ignored = self.sharedInstance;
        }
    }


    + (instancetype)sharedInstance
    {
        static dispatch_once_t onceToken;

        dispatch_once(&onceToken, ^
        {
            mIsFirstAccess = NO;
            mSingleton = (XBNCEventful *)[[super allocWithZone:NULL] init];
            XBNCEventfulStatic = mSingleton;
        });
        
        return mSingleton;
    }


    + (instancetype)allocWithZone:(NSZone *)zone
    {
        return [self sharedInstance];
    }


    + (instancetype)copyWithZone:(struct _NSZone *)zone
    {
        return [self sharedInstance];
    }


    + (instancetype)mutableCopyWithZone:(struct _NSZone *)zone
    {
        return [self sharedInstance];
    }


    - (instancetype)copy
    {
        return [[XBNCEventful alloc] init];
    }


    - (instancetype)mutableCopy
    {
        return [[XBNCEventful alloc] init];
    }


    - (instancetype)init
    {
        if(mSingleton){
            return mSingleton;
        }

        if (mIsFirstAccess) {
            [self doesNotRecognizeSelector:_cmd];
        }

        self = [super init];

        [self initializeEventful];

        return self;
    }


    #pragma mark - Public Methods - Send


    - (void)sendEvent:(NSUInteger)eventId
               sender:(id)sender
                 data:(NSDictionary *)data
    {
        [self sendEvent:eventId sender:sender data:data onSuccess:nil onFail:nil];
    }


    - (void)sendEvent:(NSUInteger)eventId
               sender:(id)sender
                 data:(NSDictionary *)data
            onSuccess:(void (^)(void))onSuccess
               onFail:(void (^)(void))onFail
    {
        NSAssert((sender != nil), @"`sender` is nil!");

        // for the event id, get array of receivers
        NSMutableArray *arrayOfReceivers = (NSMutableArray *)_events[@(eventId)];

        // if array is nil
        if (!arrayOfReceivers)
        {
            // NOTE: this is not needed, because we have onSuccess & onFail blocks that tell us what happened
            //NSAssert(false, @"Mismatch found! Trying to send event id `%ld`, but there is no receiver!", eventId);

            if (onFail) {
                onFail();
            }
        }
        else
        {
            // call receivers i.e. send event to them

            /*[arrayOfReceivers enumerateObjectsWithOptions:NSEnumerationConcurrent
                                               usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                                               {
                                                   XBNCEventReceiver *eventReceiver = (XBNCEventReceiver *)obj;

                                                   // check limits reached
                                                   if (eventReceiver.triggerCount == eventReceiver.triggerLimit)
                                                   {
                                                       XBNCLogC("XBNCEventful (sendEvent): Trigger limit `%ld` is already reached, event id `%ld` won't be sent anymore for this receiver!", eventReceiver.triggerLimit, eventId)
                                                       if (onFail) {
                                                           onFail();
                                                       }
                                                       return;
                                                   }

                                                   eventReceiver.triggerCount++;

                                                    // block
                                                   if (eventReceiver.receiverBlock)
                                                   {
                                                       XBNCEvent *event = XBNCEvent.new;
                                                       event.eventId = eventId;
                                                       event.sender = sender;
                                                       event.data = data;
                                                       event.triggerCount = eventReceiver.triggerCount;
                                                       event.triggerLimit = eventReceiver.triggerLimit;

                                                       eventReceiver.receiverBlock(event);
                                                   }
                                                   else
                                                   {
                                                       // selector
                                                       [eventReceiver.object performSelector:eventReceiver.selector withObject:data];

                                                       *//*NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[eventReceiver class]
                                                                                                                                       instanceMethodSignatureForSelector:eventReceiver.selector]];
                                                       invocation.target = eventReceiver;
                                                       invocation.selector = eventReceiver.selector;
                                                       [invocation setArgument:(__bridge void *)data atIndex:0];
                                                       [invocation invoke];*//*
                                                   }

                                                   if (onSuccess) {
                                                       onSuccess();
                                                   }
                                               }];*/

            for (XBNCEventReceiver *eventReceiver in arrayOfReceivers)
            {
                //XBNCLogS(@"XBNCEventful (sendEvent): To receiver: %@", eventReceiver);

               // check limits reached
               if (eventReceiver.triggerCount == eventReceiver.triggerLimit)
               {
                   //XBNCLogC("XBNCEventful (sendEvent): Trigger limit `%ld` is already reached, event id `%ld` won't be sent anymore for this receiver!", (unsigned long)eventReceiver.triggerLimit, (unsigned long)(unsigned long)eventId);

                   if (onFail) {
                       onFail();
                   }

                   continue;
               }

               eventReceiver.triggerCount++;

               // create the event object to pass back
               XBNCEvent *event = XBNCEvent.new;
               event.eventId = eventId;
               event.sender = sender;
               event.data = data;
               event.triggerCount = eventReceiver.triggerCount;
               event.triggerLimit = eventReceiver.triggerLimit;

               if (eventReceiver.receiverBlock) {
                   eventReceiver.receiverBlock(event);
               }
               else
               {
                    #pragma clang diagnostic push
                    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                    [eventReceiver.object performSelector:eventReceiver.selector withObject:event];

                    #pragma clang diagnostic pop
               }

               if (onSuccess) {
                   onSuccess();
               }
           }
        }
    }


    #pragma mark - Public Methods - Receive


    - (void)receiveEvent:(NSUInteger)eventId
                receiver:(id)receiver
                selector:(SEL)selector
    {
        NSAssert((receiver != nil), @"`receiver` is nil!");
        NSAssert((selector != nil), @"`selector` is nil!");

        [self receiveEvent:eventId triggerLimit:XBNCEventTriggerLimitUnlimited receiver:receiver selector:selector block:nil];
    }


    - (void)receiveEvent:(NSUInteger)eventId
            triggerLimit:(XBNCEventTriggerLimit)triggerLimit
                receiver:(id)receiver
                selector:(SEL)selector
    {
        NSAssert((receiver != nil), @"`receiver` is nil!");
        NSAssert((selector != nil), @"`selector` is nil!");

        [self receiveEvent:eventId triggerLimit:triggerLimit receiver:receiver selector:selector block:nil];
    }


    - (void)receiveEvent:(NSUInteger)eventId
                receiver:(id)receiver
                   block:(void (^)(XBNCEvent *))block
    {
        NSAssert((receiver != nil), @"`receiver` is nil!");
        NSAssert((block != nil), @"`block` is nil!");

        [self receiveEvent:eventId triggerLimit:XBNCEventTriggerLimitUnlimited receiver:receiver selector:nil block:block];
    }


    - (void)receiveEvent:(NSUInteger)eventId
                receiver:(id)receiver
            triggerLimit:(XBNCEventTriggerLimit)triggerLimit
                   block:(void (^)(XBNCEvent *))block
    {
        NSAssert((receiver != nil), @"`receiver` is nil!");
        NSAssert((block != nil), @"`block` is nil!");

        [self receiveEvent:eventId triggerLimit:triggerLimit receiver:receiver selector:nil block:block];
    }


    #pragma mark - Public Methods - State


    - (void)stopReceivingEventId:(NSUInteger)eventId
                     forReceiver:(id)receiver
    {
        NSAssert((receiver != nil), @"`object` is nil!");

        NSString *receiverPtrAddressStr = XBNC_$(@"%p", receiver);

        // for the receiver, get array of event ids
        NSMutableArray *arrayOfEventIds = (NSMutableArray *)_receivers[receiverPtrAddressStr];

        // for all event ids in array, find receiver and remove it, in the events array
        for (NSNumber *eId in arrayOfEventIds)
        {
            // for the event id, get array of receivers
            NSMutableArray *arrayOfReceivers = (NSMutableArray *)_events[eId];

            // if array is nil
            if (!arrayOfReceivers)
            {
                NSAssert(false, @"Missmatch found! Got event id `%ld`, but there are no receivers!", eId.unsignedLongValue);
            }
            else
            {
                NSMutableArray *receiversToRemoveArray = NSMutableArray.new;

                // find receiver object in array or receivers
                [arrayOfReceivers enumerateObjectsWithOptions:NSEnumerationConcurrent
                                                   usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                                                   {
                                                       XBNCEventReceiver *eventReceiver = (XBNCEventReceiver *)obj;

                                                       if (eventReceiver.object == receiver) {
                                                            [receiversToRemoveArray addObject:eventReceiver];
                                                       }
                                                   }];

                // for the event id, remove receivers from array
                [arrayOfReceivers removeObjectsInArray:receiversToRemoveArray];
            }
        }

        // in the receivers dictionary, remove event id from events array
        [arrayOfEventIds removeObject:@(eventId)];
    }


    - (void)stopReceivingEventsForObject:(id)receiver
    {
        NSAssert((receiver != nil), @"`receiver` is nil!");

        if (_receivers.count == 0)
        {
            return;
        }
        else
        {
            NSString *receiverPtrAddressStr = XBNC_$(@"%p", receiver);

            // for the receiver, get array of event ids
            NSMutableArray *arrayOfEventIds = (NSMutableArray *)_receivers[receiverPtrAddressStr];

            // for all event ids in array, find receiver and remove it, in the events array
            for (NSNumber *eventId in arrayOfEventIds)
            {
                // for the event id, get array of receivers
                NSMutableArray *arrayOfReceivers = (NSMutableArray *)_events[eventId];

                // if array is nil
                if (!arrayOfReceivers)
                {
                    NSAssert(false, @"Missmatch found! Got event id `%ld`, but there are no receivers!", eventId.unsignedLongValue);
                }
                else
                {
                    NSMutableArray *receiversToRemoveArray = NSMutableArray.new;

                    // find receiver object in array or receivers
                    [arrayOfReceivers enumerateObjectsWithOptions:NSEnumerationConcurrent
                                                       usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                                                       {
                                                           XBNCEventReceiver *eventReceiver = (XBNCEventReceiver *)obj;

                                                           if (eventReceiver.object == receiver) {
                                                                [receiversToRemoveArray addObject:eventReceiver];
                                                           }
                                                       }];

                    // for the event id, remove receivers from array
                    [arrayOfReceivers removeObjectsInArray:receiversToRemoveArray];
                }
            }

            // remove object as receiver
            [_receivers removeObjectForKey:receiver];
        }
    }


    #pragma mark - Public Methods - Info


    - (void)eventsDescription
    {
        if (_events.count == 0) {
            XBNCLogC("XBNCEventful (eventsDescription): No events registered, the pool is empty!");
        }
        else
        {
            XBNCLogC("XBNCEventful (eventsDescription): Event pool has %ld events registered.", (unsigned long)_events.count);

            [_events enumerateKeysAndObjectsWithOptions:NSEnumerationReverse
                                             usingBlock:^(id key, id obj, BOOL *stop)
                                             {
                                                 NSNumber *eventId = (NSNumber *)key;
                                                 XBNCLogC("XBNCEventful (eventsDescription): Event Id = %ld", eventId.unsignedLongValue);
                                             }];

            /*for (NSNumber *eventId in _events) {
                XBNCLogC("XBNCEventful (eventsDescription): Event Id = %ld", eventId.unsignedLongValue);
            }*/
        }
    }


    - (void)receiversDescription
    {
        if (_receivers.count == 0) {
            XBNCLogC("XBNCEventful (receiversDescription): No receivers registered, the pool is empty!");
        }
        else
        {
            XBNCLogC("XBNCEventful (receiversDescription): Receiver pool has %ld receivers registered.", (unsigned long)_receivers.count);

            [_receivers enumerateKeysAndObjectsWithOptions:NSEnumerationReverse
                                             usingBlock:^(id key, id obj, BOOL *stop)
                                             {
                                                 XBNCLogS(@"XBNCEventful (receiversDescription): Receiver = `%@` for events = `%@`", key, _receivers[key]);
                                             }];

            /*for (id receiver in _receivers) {
                XBNCLogS(@"XBNCEventful (receiversDescription): Receiver = `%@` for events = `%@`", receiver, _receivers[receiver]);
            }*/
        }
    }


    - (void)eventsAndReceiversDescription
    {
        if (_events.count == 0) {
            XBNCLogC("XBNCEventful (eventsAndReceiversDescription): No events registered, the pool is empty!");
        }
        else
        {
            XBNCLogC("XBNCEventful (eventsAndReceiversDescription): Pool contains %ld events…", (unsigned long)_events.count);

            [_events enumerateKeysAndObjectsWithOptions:NSEnumerationReverse
                                             usingBlock:^(id key, id obj, BOOL *stop)
                                             {
                                                 NSNumber *eventId = (NSNumber *)key;
                                                 XBNCLogS(@"XBNCEventful (eventsAndReceiversDescription): Event Id=%ld, Receivers=%@", eventId.unsignedLongValue, obj);
                                             }];
        }
    }


    #pragma mark - Private


    - (void)initializeEventful
    {
        _events = NSMutableDictionary.dictionary;
        _receivers = NSMutableDictionary.dictionary;
    }


    - (void)receiveEvent:(NSUInteger)eventId
            triggerLimit:(XBNCEventTriggerLimit)triggerLimit
                receiver:(id)receiver
                selector:(SEL)selector
                   block:(void (^)(XBNCEvent *))block
    {
        // No assertions here, as we expect the public methods to handle that. //

        NSNumber *evtId = @(eventId);

        // for the event id, get array of receivers
        NSMutableArray *arrayOfReceivers = (NSMutableArray *)_events[evtId];

        // if array is nil
        if (!arrayOfReceivers)
        {
            // create new event receiver
            XBNCEventReceiver *newEventReceiver = XBNCEventReceiver.new;
            newEventReceiver.triggerLimit = triggerLimit;
            newEventReceiver.triggerCount = 0;
            newEventReceiver.object = receiver;
            newEventReceiver.selector = selector;
            newEventReceiver.receiverBlock = block;

            // create new array, add new event receiver
            NSMutableArray *arrayForFirstEventReceiver = NSMutableArray.array;
            [arrayForFirstEventReceiver addObject:newEventReceiver];

            // put array in events dictionary
            _events[evtId] = arrayForFirstEventReceiver;
        }
        else
        {
            // create new event receiver
            XBNCEventReceiver *newEventReceiver = XBNCEventReceiver.new;
            newEventReceiver.triggerLimit = triggerLimit;
            newEventReceiver.triggerCount = 0;
            newEventReceiver.object = receiver;
            newEventReceiver.selector = selector;
            newEventReceiver.receiverBlock = block;

            // update array, add new event receiver
            [arrayOfReceivers addObject:newEventReceiver];

            // put array in events dictionary
            _events[evtId] = arrayOfReceivers;
        }

        NSString *receiverPtrAddressStr = XBNC_$(@"%p", receiver);

        // for the receiver, get array of event ids
        NSMutableArray *arrayOfEventIds = (NSMutableArray *)_receivers[receiverPtrAddressStr];

        // if array is nil
        if (!arrayOfEventIds)
        {
            // create new array, add new event id
            NSMutableArray *arrayForFirstEventId = NSMutableArray.array;
            [arrayForFirstEventId addObject:@(eventId)];

            // put array in receivers dictionary
            _receivers[receiverPtrAddressStr] = arrayForFirstEventId;
        }
        else
        {
            // update array, add new event id
            [arrayOfEventIds addObject:@(eventId)];

            // put array in receivers dictionary
            _receivers[receiverPtrAddressStr] = arrayOfEventIds;
        }
    }


@end

