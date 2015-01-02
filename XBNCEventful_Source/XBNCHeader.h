//
//  XBNCHeader.h
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

