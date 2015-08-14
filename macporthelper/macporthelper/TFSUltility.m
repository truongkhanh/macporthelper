//
//  TFSUltility.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "TFSUltility.h"
#import <AppKit/AppKit.h>

@implementation TFSUltility
- (BOOL)checkout:(NSURL *)filePath
{
    NSLog(@"Checking out %@ ...", [filePath path]);
    
    NSDictionary *errorInfo = nil;
    NSString *command = [NSString stringWithFormat: @"tf checkout %@", [filePath path]];
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    NSAppleEventDescriptor * result = [as executeAndReturnError:&errorInfo];
    if(errorInfo){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Fail to check out"];
        [alert runModal];
    }
    
    return (errorInfo == nil);
}
@end
