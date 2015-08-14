//
//  VCXImporter.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "VCXImporter.h"
#import <AppKit/AppKit.h>


@implementation VCXImporter
- (BOOL)import:(NSString *)filePath vcProj:(NSString*)filePath2
{

    NSLog(@"Import %@ ...", filePath);
    //TODO compute xcode path
    
    
    NSDictionary *errorInfo = nil;
    NSString *command = [NSString stringWithFormat: @"tell application \"Terminal\"\n if not (exists window 1) then reopen\n activate\n do script \"/Users/truongkhanh/Desktop/adder/add %@ %@\" in window 1\n end tell", filePath, filePath2];

    NSLog(command);
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    NSAppleEventDescriptor * result = [as executeAndReturnError:&errorInfo];
    if(errorInfo){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:errorInfo];
        [alert runModal];
    }
    
    return (errorInfo == nil);
    
    
    return FALSE;
}
@end
