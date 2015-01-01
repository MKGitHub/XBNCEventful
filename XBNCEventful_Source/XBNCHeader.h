//
//  XBNCHeader.h
//  XBNCEventful
//
//  Created by Mohsan Khan on 2014-12-24.
//  Copyright (c) 2014 Xybernic. All rights reserved.
//


/*!
 * @brief  Header file with useful macros.
 *
 * @since 1.0.0
 */


#ifndef XBNCEventful_XBNCHeader_h
#define XBNCEventful_XBNCHeader_h


    #pragma mark - Event Trigger Limit


    /*!
     * @define  XBNCEventTriggerLimit
     *
     * @abstract Macro typedef (NSUInteger) for convenience.
     *
     * @since 1.0.0
     */
    #define XBNCEventTriggerLimit             NSUInteger

    /*!
     * @define  XBNCEventTriggerLimitUnlimited
     *
     * @abstract Macro typedef (NSUIntegerMax) for convenience.
     *
     * @since 1.0.0
     */
    #define XBNCEventTriggerLimitUnlimited    NSUIntegerMax


    #pragma mark - Standard Console Logging (Private, used internally)


    /*!
     * @abstract Logging.
     *
     * @since 1.0.0
     */
    #define XBNCLogNL                   printf("\n");

    #define XBNCLogC(fmt, ...)          printf(fmt, ## __VA_ARGS__); printf("\n");
    #define XBNCLogCi(fmt, ...)         printf(fmt, ## __VA_ARGS__);

    #define XBNCLogS(fmt, ...)          printf("%s\n", [[NSString stringWithFormat: fmt, ## __VA_ARGS__] cStringUsingEncoding: NSUTF8StringEncoding]);
    #define XBNCLogSi(fmt, ...)         printf("%s", [[NSString stringWithFormat: fmt, ## __VA_ARGS__] cStringUsingEncoding: NSUTF8StringEncoding]);

    #define XBNCTestLogS(fmt, ...)          printf(">>>>> [XBNCEventful Test] %s\n", [[NSString stringWithFormat: fmt, ## __VA_ARGS__] cStringUsingEncoding: NSUTF8StringEncoding]);

    #define XBNCCalledLog(fmt, ...)     printf("[CALLED] %s %s\n", __FUNCTION__, [[NSString stringWithFormat: fmt, ## __VA_ARGS__] cStringUsingEncoding: NSUTF8StringEncoding]);

    #define XBNCError(fmt, ...)         printf("[ERROR] %s\n", [[NSString stringWithFormat: fmt, ## __VA_ARGS__] cStringUsingEncoding: NSUTF8StringEncoding]);


    #pragma mark - Strings  (Private, used internally)


    /*!
     * @abstract Strings.
     *
     * @since 1.0.0
     */
    #define XBNC_$(...)                  [NSString stringWithFormat:__VA_ARGS__, nil]
    #define XBNC_STR_FORMAT(fmt, ...)    [NSString stringWithFormat: fmt, ## __VA_ARGS__]
    #define XBNC_STR_JOIN(_a_, _b_)           [(_a_) stringByAppendingString:(_b_)]


#endif

