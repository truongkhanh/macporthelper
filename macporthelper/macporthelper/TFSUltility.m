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
    NSString *command = [NSString stringWithFormat: @"tell application \"Terminal\"\n if not (exists window 1) then reopen\n activate\n do script \"tf checkout %@\" in window 1\n end tell", [filePath path]];
    NSLog(command);
    
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    [as executeAndReturnError:nil];
    
    
    return nil;
}
@end
