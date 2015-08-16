//
//  TerminalUltility.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "TerminalUltility.h"
#import "Ultility.h"

@implementation TerminalUltility
- (void)open:(NSString *)filePath
{
    NSString *parentFolderPath = [filePath stringByDeletingLastPathComponent];
    NSLog(@"Open Terminal @ %@", parentFolderPath);
    [self openTerminal:parentFolderPath];
}

- (void)openTerminal:(NSString*)path
{
    NSString *command = [NSString stringWithFormat:@"cd %@", path];
    command = [Ultility buildCommand:command];
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    [as executeAndReturnError:nil];
}

@end
