//
//  HelloObject.m
//  XBNCEventful Demo
//
//  Created by Mohsan Khan on 2015-01-16.
//  Copyright (c) 2015 Xybernic. All rights reserved.
//

#import "HelloObject.h"

#import "XBNCHeader.h"
#import "XBNCEventful.h"


@interface HelloObject ()
@end


@implementation HelloObject


    - (id)init
    {
        if ((self = [super init]) != nil)
        {
            XBNCLogS(@"`init` called for `HelloObject`.");
        }

        return self;
    }


    - (void)dealloc
    {
        XBNCLogS(@"`dealloc` called for `HelloObject`.");
    }


@end

