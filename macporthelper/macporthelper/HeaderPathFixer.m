//
//  HeaderPathFixer.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "HeaderPathFixer.h"

@implementation HeaderPathFixer
- (void)fix:(NSURL *)filePath
{
    NSLog(@"Fix header file: %@", [filePath absoluteString]);
    //Follow here http://www.overacker.me/blog/2015/01/25/creating-an-xcode-plugin
}
@end
