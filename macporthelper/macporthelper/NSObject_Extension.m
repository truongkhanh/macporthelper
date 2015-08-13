//
//  NSObject_Extension.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 13/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//


#import "NSObject_Extension.h"
#import "macporthelper.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[macporthelper alloc] initWithBundle:plugin];
        });
    }
}
@end
