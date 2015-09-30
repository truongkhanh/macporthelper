//
//  Ultility.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 16/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "Ultility.h"

@implementation Ultility

+ (NSString *) buildCommand: (NSString *) command
{
    NSMutableString *result = [[NSMutableString alloc] init];
    [Ultility append: result withLine: @"tell application \"Terminal\""];
    [Ultility append: result withLine: @"if not (exists window 1) then reopen"];
    [Ultility append: result withLine: @"activate"];
    [Ultility append: result withLine: [NSString stringWithFormat:@"do script \"%@\" in window 1", command]];
    [Ultility append: result withLine: @"end tell"];

    return [NSString stringWithString:result];
}

+ (void) append: (NSMutableString *) s withLine: (NSString *) line
{
    [s appendFormat:@"%@\n", line];
}
@end
