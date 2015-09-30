//
//  VCXImporter.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "VCXImporter.h"
#import <AppKit/AppKit.h>
#import "Ultility.h"

@implementation VCXImporter
- (BOOL)importVCXProj:(NSString *)vcxProj toXCodeProj:(NSString*)xcodeProj
{

    NSLog(@"Import %@ VCX Project to %@ XCode Project", vcxProj, xcodeProj);
    
    NSString *command = [NSString stringWithFormat:@"$ACMTOP/xcodeproject/MacPortingTools/add %@ %@", vcxProj, xcodeProj];
    command = [Ultility buildCommand:command];

    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: command];
    [as executeAndReturnError:nil];
    
    return TRUE;
}
@end
