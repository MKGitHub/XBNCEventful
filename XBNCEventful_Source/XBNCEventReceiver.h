//
//  XBNCEventReceiver.h
//  XBNCEventful
//
//  Created by Mohsan Khan on 2014-12-24.
//  Copyright (c) 2014 Xybernic. All rights reserved.
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

