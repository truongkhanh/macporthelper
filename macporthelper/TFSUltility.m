//
//  TFSUltility.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "TFSUltility.h"
#import <AppKit/AppKit.h>
#import "Ultility.h"

@implementation TFSUltility
- (BOOL)checkout:(NSString *)filePath
{

    NSLog(@"Checking out %@ ...", filePath);
    NSString *command = [NSString stringWithFormat:@"tf checkout %@", filePath];
    command = [Ultility buildCommand:command];
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    [as executeAndReturnError:nil];
    
    return TRUE;
}
@end
