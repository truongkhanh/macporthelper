//
//  Ultility.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 16/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "Ultility.h"

@implementation Ultility

+ (BOOL)checkout:(NSString *)filePath
{
    
    NSLog(@"Checking out %@ ...", filePath);
    NSString *command = [NSString stringWithFormat:@"tf checkout %@", filePath];
    command = [Ultility buildCommand:command];
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    [as executeAndReturnError:nil];
    
    return TRUE;
}

+ (BOOL)revert:(NSString *)filePath
{
    
    NSLog(@"Revert change in %@ ...", filePath);
    NSString *command = [NSString stringWithFormat:@"tf undo %@", filePath];
    command = [Ultility buildCommand:command];
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    [as executeAndReturnError:nil];
    
    return TRUE;
}

+ (void)openInFinder:(NSString*)path
{
    NSString *command = [NSString stringWithFormat:@"open %@", path];
    command = [Ultility buildCommand:command];
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    [as executeAndReturnError:nil];
}

+ (void)openTerminalOnFolder:(NSString*)path
{
    NSString *command = [NSString stringWithFormat:@"cd %@", path];
    command = [Ultility buildCommand:command];
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    [as executeAndReturnError:nil];
}

+ (void)print:(NSString *)message
{
    NSString *command = [NSString stringWithFormat:@"echo %@", message];
    command = [Ultility buildCommand:command];
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    [as executeAndReturnError:nil];
    
}

+ (NSString *) buildCommand: (NSString *) command
{
    NSMutableString *result = [[NSMutableString alloc] init];
    [Ultility append: result withLine: @"tell application \"Terminal\""];
    [Ultility append: result withLine: @"activate"];
    [Ultility append: result withLine: [NSString stringWithFormat:@"do script \"%@\"", command]];
    [Ultility append: result withLine: @"end tell"];
    
    return [NSString stringWithString:result];
}

+ (void) append: (NSMutableString *) s withLine: (NSString *) line
{
    [s appendFormat:@"%@\n", line];
}
@end
