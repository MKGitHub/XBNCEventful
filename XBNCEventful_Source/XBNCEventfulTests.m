//
//  XBNCEventfulTests.m
//  XBNCEventfulTests
//
//  Created by Mohsan Khan on 2014-12-26.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//

#import "TargetConditionals.h" 

#if TARGET_OS_IPHONE
    @import UIKit;
#else
    @import Cocoa;
#endif

#import <XCTest/XCTest.h>

#import "XBNCEventful.h"


/*!
 * @brief  Test cases for both Mac OS X and iOS.
 *
 * @since 1.0.0
 */


@interface XBNCEventfulTests:XCTestCase
@end


@implementation XBNCEventfulTests


    #pragma mark - Life Cycle


    - (void)setUp
    {
        [super setUp];
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // initialize singleton static symbol
        __unused id ignored = XBNCEventful.sharedInstance;
    }


    - (void)tearDown
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        [super tearDown];
    }


    #pragma mark - Test + Block


    - (void)test_Send_1_Event
    {
        [[XBNCEventful sharedInstance] receiveEvent:9001
                                           receiver:@"test_Send_1_Event"
                                              block:^(XBNCEvent *event)
        {
            XCTAssertEqual(1, event.triggerCount, @"Pass");

            XBNCTestLogS(@"Event `9001` received in block: %@", event);
        }];

        [[XBNCEventful sharedInstance] sendEvent:9001 sender:self data:@{@"keyInDict":@"valueInDict"}];

        XCTAssert(YES, @"Pass");
    }


    - (void)test_Send_10_Events
    {
        __block NSUInteger eventTriggerCounter = 0;

        [[XBNCEventful sharedInstance] receiveEvent:9002
                                           receiver:@"test_Send_10_Events"
                                              block:^(XBNCEvent *event)
        {
            XBNCTestLogS(@"Event `9002` received in block: %@", event);
            XBNCTestLogS(@"Event `triggerCount` should increase by +1…");

            eventTriggerCounter++;

            XCTAssertEqual(eventTriggerCounter, event.triggerCount, @"Pass");
        }];

        for (NSUInteger i = 0; i < 10; i++) {
            [[XBNCEventful sharedInstance] sendEvent:9002 sender:self data:@{@"keyInDict":@"valueInDict"}];
        }

        XCTAssert(YES, @"Pass");
    }


    - (void)test_Send_5_Events_But_ReceiveWithLimitOfOnly_3
    {
        __block NSUInteger eventTriggerCounter = 0;

        [XBNCEventfulStatic receiveEvent:9003
                                receiver:@"test_Send_5_Events_But_ReceiveWithLimitOfOnly_3"
                            triggerLimit:3
                                   block:^(XBNCEvent *event)
        {
            eventTriggerCounter++;

            XCTAssertEqual(eventTriggerCounter, event.triggerCount, @"Pass");
            XCTAssert(((eventTriggerCounter >= 0) && (eventTriggerCounter <= 3)), @"Pass");

            XBNCTestLogS(@"Event `9003` received with trigger count: %ld", (unsigned long)event.triggerCount);
        }];

        for (NSUInteger i = 0; i < 5; i++) {
            [XBNCEventfulStatic sendEvent:9003 sender:self data:nil];
        }

        XCTAssert(YES, @"Pass");
    }


    - (void)test_SendEvent_Success_Block
    {
        [XBNCEventfulStatic receiveEvent:9004
                                receiver:@"test_SendEvent_Success_Block"
                                   block:^(XBNCEvent *event) {
                                       XBNCTestLogS(@"Event `9004` received.");
                                   }];

        __block BOOL isSuccess;

        [XBNCEventfulStatic sendEvent:9004 sender:self data:nil
                            onSuccess:^
                            {
                                XBNCTestLogS(@"Event `9004` was successfully sent & received, because there is a receiver.");
                                isSuccess = YES;
                            }
                               onFail:^
                               {
                                   XBNCTestLogS(@"Event `9004` failed to send, because there is no receiver.");
                                   isSuccess = NO;
                               }];

        XCTAssert((isSuccess == YES), @"Pass");
    }


    - (void)test_SendEvent_FailBlock_Because_NoReceiver
    {
        // NOTE: this code is intentionally disabled
        /*[XBNCEventfulStatic receiveEvent:9005
                                receiver:@"test_SendEvent_FailBlock_Because_NoReceiver"
                                   block:^(XBNCEvent *event) {
                                       XBNCTestLogS(@"Event `9005` received.");
                                   }];*/

        __block BOOL isSuccess;

        [XBNCEventfulStatic sendEvent:9005 sender:self data:nil
                            onSuccess:^
                            {
                                XBNCTestLogS(@"Event `9005` was successfully sent & received, because there is a receiver.");
                                isSuccess = YES;
                            }
                               onFail:^
                               {
                                   XBNCTestLogS(@"Event `9005` failed to send, because there is no receiver.");
                                   isSuccess = NO;
                               }];

        XCTAssert((isSuccess == NO), @"Pass");
    }


    - (void)test_SendEvent_FailBlock_Because_WrongReceiver
    {
        [XBNCEventfulStatic receiveEvent:0
                                receiver:@"test_SendEvent_FailBlock_Because_WrongReceiver"
                                   block:^(XBNCEvent *event) {
                                       XBNCTestLogS(@"Event `0` received.");
                                   }];

        __block BOOL isSuccess;

        [XBNCEventfulStatic sendEvent:9006 sender:self data:nil
                            onSuccess:^
                            {
                                XBNCTestLogS(@"Event `9006` was successfully sent & received, because there is a receiver.");
                                isSuccess = YES;
                            }
                               onFail:^
                               {
                                   XBNCTestLogS(@"Event `9006` failed to send, because there is no receiver.");
                                   isSuccess = NO;
                               }];

        XCTAssert((isSuccess == NO), @"Pass");
    }


    #pragma mark - Test + Selector


    - (void)test_Send_1_Event_To_Selector
    {
        [XBNCEventfulStatic receiveEvent:9007 receiver:self selector:@selector(receiveEvent9007:)];

        [XBNCEventfulStatic sendEvent:9007 sender:self data:@{@"keyInDict":@"valueInDict"}];

        XCTAssert(YES, @"Pass");
    }


    - (void)test_Send_5_Events_But_ReceiveWithLimitOfOnly_3_To_Selector
    {
        [XBNCEventfulStatic receiveEvent:9008
                            triggerLimit:3
                                receiver:self
                                selector:@selector(receiveEvent9008Only3Times:)];

        for (NSUInteger i = 0; i < 5; i++) {
            [XBNCEventfulStatic sendEvent:9008 sender:self data:nil];
        }

        XCTAssert(YES, @"Pass");
    }


    #pragma mark - Test + Selector (Private Selectors)


    - (void)receiveEvent9007:(XBNCEvent *)event
    {
        XCTAssertEqual(9007, event.eventId, @"Event `9007` was not received!");
        XCTAssertEqual(1, event.triggerCount, @"Pass");

        XBNCTestLogS(@"Event `9007` was successfully sent & received, in selector with event: %@", event);
    }


    - (void)receiveEvent9008Only3Times:(XBNCEvent *)event
    {
        XCTAssertEqual(9008, event.eventId, @"Event `9008` was not received!");

        static NSUInteger event9008TriggerCounter;
        event9008TriggerCounter++;

        XCTAssertEqual(event9008TriggerCounter, event.triggerCount, @"Pass");
        XCTAssert(((event9008TriggerCounter >= 0) && (event9008TriggerCounter <= 3)), @"Pass");

        XBNCTestLogS(@"Event `9008` was successfully sent & received, in selector with event: %@", event);
    }


    #pragma mark - Test + Stop


    - (void)test_SendEvents_But_StopReceiving
    {
        __block NSUInteger event6661TriggerCounter = 0;

        [XBNCEventfulStatic receiveEvent:6661 receiver:self block:^(XBNCEvent *event)
        {
            event6661TriggerCounter++;
            XBNCTestLogS(@"This is wrong! Event `6661` should be sent but not received, in block with event: %@", event);
        }];

        [XBNCEventfulStatic stopReceivingEventId:6661 forReceiver:self];

        for (NSUInteger i = 0; i < 5; i++) {
            [XBNCEventfulStatic sendEvent:6661 sender:self data:nil];
        }

        XCTAssertEqual(event6661TriggerCounter, 0, @"Pass");
    }


    - (void)test_SendEvents_But_StopReceiving_AllEvents
    {
        __block NSUInteger eventsTriggerCounter = 0;

        [XBNCEventfulStatic receiveEvent:6662 receiver:self block:^(XBNCEvent *event)
        {
            eventsTriggerCounter++;
            XBNCTestLogS(@"This is wrong! Event `6662` should be sent but not received, in block with event: %@", event);
        }];

        [XBNCEventfulStatic receiveEvent:6663 receiver:self block:^(XBNCEvent *event)
        {
            eventsTriggerCounter++;
            XBNCTestLogS(@"This is wrong! Event `6663` should be sent but not received, in block with event: %@", event);
        }];

        [XBNCEventfulStatic stopReceivingEventsForObject:self];

        [XBNCEventfulStatic sendEvent:6662 sender:self data:nil];
        [XBNCEventfulStatic sendEvent:6663 sender:self data:nil];

        XCTAssertEqual(eventsTriggerCounter, 0, @"Pass");
    }


    #pragma mark - Test + ARC


    - (void)test_Events_And_ARC
    {
        __block NSUInteger eventsTriggerCounter = 0;
        NSString *placeholderTestStr = @"Just a string";

        [XBNCEventfulStatic receiveEvent:7000 receiver:placeholderTestStr block:^(XBNCEvent *event)
        {
            eventsTriggerCounter++;
            XBNCTestLogS(@"This is wrong! Event `7000` should be sent but not received, in block with event: %@", event);
        }];

        [XBNCEventfulStatic stopReceivingEventsForObject:placeholderTestStr];
        placeholderTestStr = nil;
        XCTAssertEqualObjects(NULL, placeholderTestStr, @"`placeholderTestStr` has been destroyed and should be (null)!");

        [XBNCEventfulStatic sendEvent:7000 sender:self data:nil];

        XCTAssertEqual(eventsTriggerCounter, 0, @"Pass");
    }


    #pragma mark - Test + Info


    - (void)test_Events_Description_LooksGood
    {
        [XBNCEventfulStatic receiveEvent:8001 receiver:self block:^(XBNCEvent *event){}];
        [XBNCEventfulStatic receiveEvent:8002 receiver:self block:^(XBNCEvent *event){}];
        [XBNCEventfulStatic receiveEvent:8003 receiver:self block:^(XBNCEvent *event){}];

        [XBNCEventfulStatic eventsDescription];

        XCTAssert(YES, @"Pass");
    }


    - (void)test_Receivers_Description_LooksGood
    {
        [XBNCEventfulStatic receiveEvent:8004 receiver:self block:^(XBNCEvent *event){}];
        [XBNCEventfulStatic receiveEvent:8005 receiver:self block:^(XBNCEvent *event){}];
        [XBNCEventfulStatic receiveEvent:8006 receiver:self block:^(XBNCEvent *event){}];

        [XBNCEventfulStatic receiversDescription];

        XCTAssert(YES, @"Pass");
    }


    - (void)test_EventsAndReceivers_Description_LooksGood
    {
        [XBNCEventfulStatic receiveEvent:8007 receiver:self block:^(XBNCEvent *event){}];
        [XBNCEventfulStatic receiveEvent:8008 receiver:self block:^(XBNCEvent *event){}];
        [XBNCEventfulStatic receiveEvent:8009 receiver:self block:^(XBNCEvent *event){}];

        [XBNCEventfulStatic eventsAndReceiversDescription];

        XCTAssert(YES, @"Pass");
    }


    #pragma mark - Performance Tests


    /*
        Test Results

        2014-12-26 • Mac OS X Yosemite 10.10.1 (14B25)
                         Mac Pro (Early 2008), 2 x 3.2 GHz Quad-Core Intel Xeon, 10 GB 800 MHz DDR2 FB-DIMM,
                         500 GB SATA Disk, NVIDIA GeForce 8800 GT 512 MB
                     ~0.52 seconds

                   • iOS 8.1.2 (12B440)
                         iPhone 5 (Model A1429), 32 GB
                     ~0.58 seconds

                   • iOS 8.1.2 (12B440)
                         iPhone 6 Plus, 64 GB
                     ~0.34 seconds
    */
    - (void)testPerformance_Send_And_Receive_1000_Events
    {
        [self measureBlock:^
        {
            [XBNCEventfulStatic receiveEvent:9100
                                    receiver:@"testPerformance_Send_And_Receive_1000_Events"
                                       block:^(XBNCEvent *event)
            {
                // empty block, we only measure XBNCEventful
            }];

            for (NSUInteger i = 0; i < 1000; i++)
            {
                [[XBNCEventful sharedInstance] sendEvent:9100 sender:self data:@{@"key1":@"value1"}];
            }
        }];
    }


@end

