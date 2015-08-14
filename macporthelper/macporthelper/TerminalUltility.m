//
//  TerminalUltility.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "TerminalUltility.h"

@implementation TerminalUltility
- (void)open:(NSURL *)filePath
{
    NSLog(@"Open Terminal: %@", [filePath path]);
    [self openTerminal:[[filePath path] stringByDeletingLastPathComponent]];
}

- (void)openTerminal:(NSString*)path
{
    
    NSString *s = [NSString stringWithFormat: @"tell application \"Terminal\"\n if not (exists window 1) then reopen\n activate\n do script \"cd %@\" in window 1\n end tell", path];
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: s]; [as executeAndReturnError:nil];
}

@end
