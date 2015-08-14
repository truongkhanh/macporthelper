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
    NSLog(@"Open Terminal: %@", [filePath absoluteString]);

}
@end
